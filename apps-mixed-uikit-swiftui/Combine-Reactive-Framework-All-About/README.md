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

### Combine Intro:
`Publishers` and `Subscribers` -> A Publisher exposes values that can change on which a subscriber subscribes to receive all those updates. 
    - Publishers are the same as Observables (props those can be observed for changes by subscribers)
    - Subscribers are the same as Observers (props those listen for any changes on the publishers)

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