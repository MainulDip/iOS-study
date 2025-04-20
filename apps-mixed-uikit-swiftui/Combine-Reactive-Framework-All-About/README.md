### Why Combine (Reactive):
Without reactive, Fetching data from network and updating the UI is more like `lots of callback and nested callback`. Using callback, dealing with All `success` and `failure` cases will be difficult. 

```swift
// Example: Calling only 2 API, dealing with callback become much difficult when codebase grows
func fetchUserId(_ completionHandler: @escaping(Result<Int, Error>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        let id = 47
        completionHandler(.success(id))
    }
}

func fetchName(for userId: Int, _ completionHandler: @escaping(Result<String, Error>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let res = "Data for user \(userId)"
        completionHandler(.success(res))
    }
}

func run() {
    fetchUserId { idResult in
        switch idResult {
        case .success(let id):
            fetchName(for: id) { nameResult in
                switch nameResult {
                case .success(let name):
                    print(name)
                case .failure(let failure):
                    print("\(failure) in fetchName")
                }
            }
        case .failure(let failure):
            print("\(failure) in fetchUserId")
            // Dealing with failure will introduce more callback
        }
    }
} 
```

### Combine Intro | Publisher, Subscriber, Operators, Subjects:
`Publishers` and `Subscribers` -> A Publisher exposes values that can change on which a subscriber subscribes to receive all those updates. 
    - `Publishers` are the same as Observables (props those can be observed for changes by subscribers)
        - Ex: `Just`, `Future`, `Deferred`, `Empty`, `Sequence`, `Fail`, `Record`, `Share`, `Multicast`
        - For SwiftUI: `@ObservableObject`, `@Published`
    - `Subscribers` are the same as Observers (props those listen for any changes on the publishers)
        - unless a Subscriber is attached, the Publisher will not emit data
        - All Subscribers conform to the `Cancellable` protocol
        - Ex: `sink` and `assign`
    - `Operators` are prebuilt functions included under Publisher, are used for business logic, encoding/decoding, error handling, retry logic, buffering and prefetch, and supporting debugging
        - Mapping Operators: `scan`, `map`, `tryScan`, `setFailureType`, `tryMap`, `flatMap`
        - Filtering: `filter`, `tryFilter`, `removeDuplicate`
        - Reducing: `collect`, `reduce`, `tryReduce`
        - Mathematic: `max`, `min`, `count`
        - Matching criteria: `allSatisfy`, `contains`, `containsWhere`
        - Sequence Operators: `first`, `firstWhere`, `prepend`, `drop`, `dropWhile`, `tryDropWhile`, `output`
        - Multiple Publisher Combining Operators: `combineLatest`, `merge`, `zip`
        - Handling Error: `catch`, `tryCatch`, `retry`, `assertNotFailure`
    - `Subjects` are publisher conforming to the `Subject` protocol, it requires to have a `.send(_:)` method to send specific values to a single or multiple subscribers
        - Ex: `CurrentValueSubject` (requires initial state) and `PassthroughSubject` (doesn't require initial state). Both will emit updates when `.send()` is invoked
        - Both are also useful for creating publisher for object conforming to `ObservableObject` protocol in SwiftUI

* If we imagine a `Combine` workflow as a pipeline, the `Publisher` and `Subjects` (Special king of Publisher) are entry point, the Subscribers are the end of the pipeline, and `Operator` lives in the middle of the pipeline.
    

### Combine Setup Initial:
Note: all `.sink` callers needs to be stored, either separately or using set of AnyCancellable `[AnyCancellable]`. Otherwise observation will not work
```swift
import UIKit
import Combine

class ViewController: UIViewController {
    
    // private var observer: AnyCancellable?
    private var observers: [AnyCancellable] = []
    private var viewModel: [String] = []

    let action = PassthroughSubject<String, Never>() // 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didFetchData()
    }
    
    // call ApiCaller using the singleton and update ui using combine
    private func didFetchData() {
        // observer
        APICaller.shared.fetchCompanies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                    case .failure(let error):
                    print("failed with error: \(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.viewModel = value
                self?.tableView.reloadData()
            }).store(in: &observers)
    }


    // changing a tableViewCell's button title from tapping the same button
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReusableIdentifire, for: indexPath) as! CustomCell

        cell.label.text = viewModel[indexPath.row]
        cell.action.sink { string in
            cell.button.setTitle(string, for: .normal)
            print(string)
        }.store(in: &observers) // all sink's return's need to be stored, otherwise it will not be get called
        return cell
    }


    // a button press handler to update info to the receiver
    @objc private func handleButtonTapped() {
        action.send("Button Tapped") // 4
    }
}

// APICaller.swift File -------------------------


import Foundation
import Combine

class APICaller {
    static let shared = APICaller() // singleton
    // access everything on this class using this instance
    
    private init(){} // blocking instantiation of this class
    
    func fetchCompanies() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let companies = ["A", "B"]
                promise(Result.success(companies))
            }
        }
    }
    
    // without combine, a completion handler is used, the completion handler is a closure here
    func fetchDataWithCompletionHandler(completion: ([String]) -> Void) {
        // do network call and supply the result into the closure's parameter
        // so that the ui can be updated
        let data = ["Data1", "Data2", "Data3"]
        completion(data)
    }
}
```

### `Result<Success, Failure>`:
```swift
enum EntropyError: Error {
    case entropyDepleted
}


struct UnreliableRandomGenerator {
    func random() throws -> Int {
        if Bool.random() {
            return Int.random(in: 1...100)
        } else {
            throw EntropyError.entropyDepleted
        }
    }
}

struct RandomnessMonitor {
    let randomnessSource: UnreliableRandomGenerator
    var results: [Result<Int, Error>] = []


    init(generator: UnreliableRandomGenerator) {
        randomnessSource = generator
    }


    mutating func sample() {
        let sample = Result { try randomnessSource.random() }
        results.append(sample)
    }


    func summary() -> (Double, Double) {
        let totals = results.reduce((sum: 0, count: 0)) { total, sample in
            switch sample {
            case .success(let number):
                return (total.sum + number, total.count)
            case .failure:
                return (total.sum, total.count + 1)
            }
        }


        return (
            average: Double(totals.sum) / Double(results.count - totals.count),
            failureRate: Double(totals.count) / Double(results.count)
        )
    }
}

var monitor = RandomnessMonitor(generator: UnreliableRandomGenerator())
(0..<1000).forEach { _ in monitor.sample() }
let (average, failureRate) = monitor.summary()
print("Average value: \(average), failure rate: \(failureRate * 100.0)%.")
// Prints values such as: "Average value: 47.95, failure rate: 48.69%."

```