### Why Combine (Reactive):
Without reactive, Fetching data from network and updating the UI is more like `lots of callback and nested callback`. Using callback, dealing with All `success` and `failure` cases will be difficult.......

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
        - Ex: `sink` and `assign`, and `onReceive` specifically for SwiftUI
        - `onReceive` takes a closure like `sink`, that can mutate `@State` or `@Bindings`
    - `Operators` are prebuilt functions included under Publisher, are used for business logic, encoding/decoding, error handling, retry logic, buffering and prefetch, and supporting debugging
        - Mapping Operators: `scan`, `map`, `tryScan`, `setFailureType`, `tryMap`, `flatMap`
        - Filtering: `filter`, `tryFilter`, `removeDuplicate`
        - Reducing: `collect`, `reduce`, `tryReduce`
        - Mathematic: `max`, `min`, `count`
        - Matching criteria: `allSatisfy`, `contains`, `containsWhere`
        - Sequence Operators: `first`, `firstWhere`, `prepend`, `drop`, `dropWhile`, `tryDropWhile`, `output`
        - Multiple Publisher Combining Operators: `combineLatest`, `merge`, `zip`
        - Handling Error: `catch`, `tryCatch`, `retry`, `assertNotFailure`
    - `Subjects` are publisher conforming to the `Subject` protocol, used to inject values into data stream using a `.send(_:)` method to send/emit specific values to a single or multiple subscribers
        - Ex: `CurrentValueSubject` (requires initial state) and `PassthroughSubject` (doesn't require initial state). Both will emit updates when `.send()` is invoked
        - Both are also useful for creating publisher for object conforming to `ObservableObject` protocol in SwiftUI

* If we imagine a `Combine` workflow as a pipeline, the `Publisher` and `Subjects` (Special king of Publisher) are entry point, the Subscribers are the end of the pipeline, and `Operator` lives in the middle of the pipeline.


### Combine TLDR | Frequently Used `Publishers`, `Subscriber` and Built-in + Custom Publisher/Subscriber:
Built-in Publishers:
- `Just`
- `Future`
- `PassthroughSubject` & `CurrentValueSubject`
- `Empty`
- `Deferred`
- `Timer`

System Provided Publishers:
- NotificationCenter Publisher
- KeyPath Binding Publisher
- Combine's SwiftUI Publisher `@Published` for `ViewModel: ObservableObject`


Operators as publisher: 
`CombineLatest`, `Map`, and `FlatMap` can create new publishers by transforming or combining existing ones

Built-in Subscriber:
- `sink`
- `assign`

Custom Publisher:
```swift
struct MyPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, MyPublisher.Failure == S.Failure, MyPublisher.Output == S.Input {
        subscriber.receive(subscription: Subscriptions.empty)
    }
}
```

Custom Subscriber:
```swift
struct MySubscriber: Subscriber {
    typealias Input = String
    typealias Failure = Never

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value: \(input)")
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
}
```

https://medium.com/@amitaswal87/combine-in-swift-third-part-types-of-publishers-and-subscribers-40175524b601

### Combine basic usages (intro 1):
```swift
// storage for `sink` (sink and assign all returns AnyCancellable
var cancellables: Set<AnyCancellable> = []

func run() {
    // Just is the simpliest built-in publisher
    Just(42)
        .delay(for: 2, scheduler: DispatchQueue.main)
        .sink { value in // receiving value by a sink subscriber
            print(value)
        }
        .store(in: &cancellables) // storing sikns's return (AnyCancellable)
    
    [1, 2, 3, 4, 5, 6, 7]
        .publisher // built-in publisher for sequence
        .delay(for: 1, scheduler: DispatchQueue.main)
        .sink { value in
            print(value)
        }
        .store(in: &cancellables)
    
    [1, 2, 3, 4, 5, 6, 7]
        .publisher
        .filter { value -> Bool in value.isMultiple(of: 2) == false}
        .print() // built-in debugging operator
        .map { $0 * $0 } // map, filter's all are operator for publishers
        .delay(for: 1, scheduler: DispatchQueue.main)
        .sink { value in
            print(value)
        }
        .store(in: &cancellables)
}
/*
As everything in Combine is Async
The code above that has longer delays will be print last
*/
```

### Building `Publisher`:
Usually publishers are 2 types, but can be mixed (using operators)
    - one-shot: emit single value and completes
    - multi-shot / continuous: emit multiple values over time

- URLSession.dataTaskPublisher
- Future (one-shot publisher)
- Just (one-shot)
- PassThroughSubject and CurrentValueSubject (multi-shot)

### Scheduler | Threads:
Publishers and Operators can run on different dispatchQueue and runloops, So, a subscriber needs to specify a `scheduler`. For uiUpdates, scheduler should be the `main thread` (RunLoop.main)
    - receive(on: RunLoop.main) and subscribe are 2 function
        that need to specify scheduler
    - some operators, like, `delay`, `debounce` and `throttle` needs to specify scheduler.

```swift
// Assuming the code is on a ViewModel, and for creating subscriber
APublisherReturningNetworkFunction()
    .subscribe(on: backgroundQueue) // perform upstream operations on backgroundQueue
    .receive(on: RunLoop.main) // receive the result on Main queue
```

### `RunLoop.main` vs `DispatchQueue.main`:
The scheduler `DispatchQueue.main` will be executed immediately, but `RunLoop.main` is not guaranteed for immediate execution (usually after user-interaction finished, ie, scrolling).

RunLoop manage input operations for the user, such as touches or scrolling for an application.The RunLoop.main uses several modes and switches to a non-default mode when user interaction occurs. However, RunLoop.main as a Combine scheduler only executes when the default mode is active. 

So if user is doing some interaction with the app, (ie, scrolling), the combine pipeline containing the `receive(on: RunLoop.main)` will be paused and will execute after the interaction.

https://www.avanderlee.com/combine/runloop-main-vs-dispatchqueue-main/

### `AnyPublisher<Output, Failure>` and `some Publisher` | Building Publisher:
Importance of Generic type Erasure : When publishers are built, it usually has simple generic signature (`Publisher<T,E>`), but while building the pipeline by adding `operators`, it creates a complex types to include all later operation (`<First<Second<T,E>,E>,E`). `AnyPublisher<Output, Failure>` helps to erase all those overwhelming nested types and expose a simple type so when the `subscriber` are calling, gets a simple signature to define.

```swift

```

### Single and Multi Dimensional `Publisher of Publisher`:
Publisher can be single dimensional
```swift
[1, 2, 3]
   .publisher
   .map { $0 * 2 }
   .sink { print($0) }
```

Multi dimensional publisher (publisher of publisher)
```swift
struct User {
   let name: CurrentValueSubject<String, Never>
}

let userSubject = PassthroughSubject<User, Never>()
```

### Understanding Publisher's Operator (`.map`) Signature | Generics Type:
All operators are defined inside of `extension Publisher {}`, so they are meant to be chained with a `Upstream` publisher instance.

`map` operator returns a `Publisher.Map<Self, T>` where `Self` is the Upstream Publisher and `T` is the output Publisher, as Map's signature is `Map<Upstream, Output>`. Using map, the upstream publisher can be converted into new kind of publisher. Like, handling the error case and make the new publisher's error to a `Never` type.

* We don't need to handle the `Never` type. When a Publisher is `<Output, Never>`, only output is need to be processed.

```swift
var cancelable: [AnyCancellable] = []

struct User {
    let name: CurrentValueSubject<String, Never>
}

func publisherOfPublisher() {
    let passThroughUserSubject = PassthroughSubject<User, Never>()
    /*
    => if we ignore the upstream as .map's output and pass a Just publisher, like
    : passThroughUserSubject.map { _ in Just(1) }
    => the return type
    :   Publisher.Map<PassthroughSubject<User, Never>, Just<Int>>
    => where the upstream type was
    :    PassthroughSubject<User, Never>
    */
    
    let m = passThroughUserSubject
        // .map { $0.name } // changing the upstream publisher into a publisher of User's property
        .map { $0 } // changing the upstream publisher into a full User type
    // let s = m.sink { print(" User.name: \($0.value)") } // if the publisher is a User's property (name), we can print using $0.value
    // here m: Publishers.Map<PassthroughSubject<User, Never>, User>
    let s = m.sink { print(" User.name: \($0.name.value)") } // if the publisher is a whole User type, we have to drill down to get the actual value.
    s.store(in: &cancelable)
    
    let user = User(name: .init("Mainul"))
    passThroughUserSubject.send(user)
    // prints `User.name: Mainul`
}
```

### `flatMap` operator (not work with `.switchToLatest()`):
```swift
var cancelable: [AnyCancellable] = []

struct User {
    let name: CurrentValueSubject<String, Never>
}

func publisherOfPublisherWithFlatMap() {
    let passThroughUserSubject = PassthroughSubject<User, Never>()

    let fm = passThroughUserSubject
        .flatMap { $0.name } // Publishers.FlatMap<CurrentValueSubject<String, Never>, PassthroughSubject<User, Never>>
        .eraseToAnyPublisher() // AnyPublisher<String, Never>
        .print("", to: nil)
        // .switchToLatest() // will not compile
        // flatMap will flatten down the multi dimensional publisher into a single dimensional publisher
        // and will only emit raw value, which is not a publisher property anymore (contrary to map)
        // and .switchToLatest() expect a property which is a publisher itself, not raw value
        
    let s = fm.sink { print(" User.name: \($0)") }
    s.store(in: &cancelable)
    
    let user = User(name: .init("Mainul"))
    passThroughUserSubject.send(user)
    // prints `User.name: Mainul`
}
```

### Publisher's `map`, `flatMat` and `switchToLatest`:
These are the frequently used combine's publisher's operator.

All these operators are defined inside of `extension Publisher {}`, so they are meant to be chained with a `Upstream` publisher instance.

`map` operator returns a `Publisher.Map<Self, T>` where `Self` is the Upstream Publisher and `T` is the output Publisher, as Map's signature is `Map<Upstream, Output>`. Using map, the upstream publisher can be converted into new kind of publisher. Like, handling the error case and make the new publisher's error to a `Never` type.

* We don't need to handle the `Never` type. When a Publisher is `<Output, Never>`, only output is need to be processed.



https://www.donnywals.com/using-map-flatmap-and-compactmap-in-combine/

https://www.vadimbulavin.com/map-flatmap-switchtolatest-in-combine-framework/

### `PassthroughSubject` and `CurrentValueSubject` and Subject's Lifecycle:
PassthroughSubject has no default value, doesn't capture state, it only pass-through the emitted values to the subscriber. and drop emitting when there is no subscriber attached.

```swift
struct ChatRoom {
    enum Error: Swift.Error {
        case missingConnection
    }
    let subject = PassthroughSubject<String, Error>()
    
    func simulateMessage() {
        subject.send("Hello!")
    }
    
    func simulateNetworkError() {
        subject.send(completion: .failure(.missingConnection))
    }
    
    func closeRoom() {
        subject.send("Chat room closed")
        subject.send(completion: .finished)
    }
}

let chatRoom = ChatRoom()
chatRoom.subject.sink { completion in
    switch completion {
    case .finished:
        print("Received finished")
    case .failure(let error):
        print("Received error: \(error)")
    }
} receiveValue: { message in
    print("Received message: \(message)")
}

chatRoom.simulateMessage()
chatRoom.closeRoom()
// after calling closeRoom or simulateNetworkError, the pipeline is closed and the publisher will not emit any value, unless a new subscriber is attached. 

// Received message: Hello!
// Received message: Chat room closed
// Received finished 
```

CurrentValueSubject has default value (state), subscribers will receive this initial value upon subscribing


```swift
struct Uploader {
    enum State {
        case pending, uploading, finished
    }
    
    enum Error: Swift.Error {
        case uploadFailed
    }
    
    let subject = CurrentValueSubject<State, Error>(.pending)
    
    func startUpload() {
        subject.send(.uploading)
    }
    
    func finishUpload() {
        subject.value = .finished
        subject.send(completion: .finished)
    }
    
    func failUpload() {
        subject.send(completion: .failure(.uploadFailed))
    }
}

let uploader = Uploader()
uploader.subject.sink { completion in
    switch completion {
    case .finished:
        print("Received finished")
    case .failure(let error):
        print("Received error: \(error)")
    }
} receiveValue: { message in
    print("Received message: \(message)")
}

uploader.startUpload()
uploader.finishUpload()

// Received message: pending
// Received message: uploading
// Received message: finished
// Received finished
```

Subject's Lifecycle: Whenever a finished (finished or failure) event is received, the subject's subscription is done, it will not emit any value upon the `.send` method call.
Note: Check sink and assign behavior with subject

https://www.avanderlee.com/combine/passthroughsubject-currentvaluesubject-explained/

### Republishing of Subject:
```swift
class MyViewController : UIViewController {
    let initialPublisher: PassthroughSubject = PassthroughSubject<Void, Never>()
    var rePublisher: AnyPublisher<Void, Never> {
        initialPublisher.eraseToAnyPublisher()
    }
    private var cancellableSubscriber = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        let button: UIButton = {
            let result = UIButton(type: .system)
            result.frame = CGRect(x: 100, y: 100, width: 200, height: 20)
            result.setTitle("Button", for: .normal)
            result.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return result
        }()
        view.backgroundColor = .white
        view.addSubview(button)
        
        rePublisher
            .sink {
                print("Received!") // works!
            }
            .store(in: &cancellableSubscriber)
    }

    @objc private func buttonAction() {
        initialPublisher.send()
    }
}
```

### Subscribers `sink` & `assign`:
Subscriber is need to be chained with a publisher, usually after specifying a scheduler with `receive(on:)` on the pipeline.

`.sink` handles both success and error case
`.assign` only handle (output) success, so for handling error, `.catch` needs to be chained before. Using `.replaceError(with:[])` is also possible.

```swift
// ViewModel
final class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    var cancellables: Set<AnyCancellable> = []
    
    func fetchInitialData() {
        fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            // .replaceError(with: []) // instead of using `.catch` block, this can also be used
            .catch { error in
                print("Error: \(error)")
                return Empty<[Movie], Never>()
            }
            // .assign(to: \.movies, on: self)
            .assign(to: &$movies) // better version than previous assign version with 2 parameters
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("Network Fetching Success and Completes")
//                case .failure(let failure):
//                    print("Network Request Failed: \(failure)")
//                }
//            }, receiveValue: { [weak self] movies in
//                self?.movies = movies
//            })
            .store(in: &cancellables)
    }
}
```

### `ViewModel` Integration and code spiting:
ViewModel class conforms to `ObservableObject`, and properties are marked with `@Published` wrapper. VM functions will update the `@Published` properties and will be called from the View. 

A property marked with `@StateObject` will get the ViewModel instance. `.onAppear` call back will call the VM function when that view is finished rendered.

Usually subscriber will be attached inside viewModel function.  

```swift
struct MoviesView: View {
    
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        List(viewModel.movies) { movie in
            HStack {
                AsyncImage(url: movie.posterURL) { poster in
                    poster.resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100)
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.caption)
                        .lineLimit(3)
                }
            }
        }
        .onAppear {
            /* call VM function, which will update the @Published VM property */
            viewModel.fetchInitialData()
        }
    }
}
```


### `onReceive` subscriber in SwiftUI:
```swift
struct MyView : View {

    @State private var currentStatusValue = "ok"
    var body: some View {
        Text("Current status: \(currentStatusValue)")
            .onReceive(MyPublisher.currentStatusPublisher) { newStatus in
                self.currentStatusValue = newStatus
            }
    }
}
```

### Combine `.sink` subscriber usages in UIKit:
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

### `@Published` as publisher using `$` prefix:
```swift

@Published var sth = "Hello World"

func publishedVarAsPublisher() {
    $sth.sink { completion in
             switch completion {
             case .finished:
                 print("")
             }
        } receiveValue: { value in
            print("value")
        }
        .store(in: &cancellables)
}
``` 

### SwiftUI Property Wrappers, combine and non-combine:
Combine related:  `@ObservedObject`, `@EnvironmentObject`, and `@Published`. SwiftUI uses these property wrappers to create a publisher that will inform SwiftUI when those models have changed, creating a objectWillChange publisher. Having an object conform to `ObservableObject` will also get a default objectWillChange publisher.

```swift
class UserProgressVM: ObservableObject {
    @Published var score = 0

    var count = 0 // without using @Published Property wrapper
    func incrementCounter() {
        count += 1
        objectWillChange.send()
    }
}

struct InnerView: View {
    @ObservedObject var progress: UserProgressVM

    var body: some View {
        Button("Increase Score") {
            progress.score += 1
        }
    }
}

struct ContentView: View {
    @StateObject var progress = UserProgressVM()

    var body: some View {
        VStack {
            Text("Your score is \(progress.score)")
            InnerView(progress: progress)
        }
    }
}
```


### `@StateObject` vs `@ObservableObject` (SwiftUI only):
`@StateObject` persist when the containing View struct redraws upon state change, but `@ObservableObject` get destroyed and re-initialized. 

Usually, when a container view calls a child view component, the viewModel is referenced in the child using `@ObservedObject` (not instantiated), and from container view, the viewModel is instantiated and marked with `@StateObject` property wrapper. 


https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/


### SwiftUI States used with Combine (but not Combine feature):
All these are managed by SwiftUI Views, ViewModel will not use these. For viewModel, we have `@Published` wrapper as publisher.
`@State`
    - top level (used in container or standalone)
`@Binding`
    - can read and write a value owned by a source (other than itself) of truth stored in other places 
    - used in child component (without instantiated), the container passed the instance referenced by `@State` to the child component
    - used to sent data back to parent view's `@State`
`@EnvironmentObject`
    - property wrapper to pass various state information (theme) between views that are not connected to each other (no hierarchy) `@EnvironmentObject var theme: Theme`
    - can be inject by `view.environmentObject(observedObjectForTheme)`, see example 
`@Environment`
    - another way to use SwiftUI environment system, by defining custom EnvironmentKey (protocol conformance) and an `extension EnvironmentValues` with computed get/set property
    - the custom Environment is then accessed by key-path `@Environment(\.propInExtension) var localProp: Type`

https://www.swiftbysundell.com/articles/swiftui-state-management-guide/

```swift
/* @EnvironmentObject */

struct ArticleView: View {
    @EnvironmentObject var theme: Theme
    var article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .foregroundColor(theme.titleTextColor)
            Text(article.body)
                .foregroundColor(theme.bodyTextColor)
        }
    }
}

struct RootView: View {
    @ObservedObject var theme: Theme
    @ObservedObject var articleLibrary: ArticleLibrary

    var body: some View {
        ArticleListView(articles: articleLibrary.articles)
            .environmentObject(theme)
    }
}
```

```swift
/* @Environment */

struct ThemeEnvironmentKey: EnvironmentKey {
    static var defaultValue = Theme.default
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

struct ArticleView: View {
    @Environment(\.theme) var theme: Theme
    var article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .foregroundColor(theme.titleTextColor)
            Text(article.body)
                .foregroundColor(theme.bodyTextColor)
        }
    }
}

```

* SwiftUI Backward Data Flow Using `@Binding`, 2 way data flow

```swift
struct ParentView: View {
  @State private var selectedItem: Item?

  var body: some View {
    VStack {
      // Other views...

      ChildView(selectedItem: $selectedItem)
    }
  }
}

struct ChildView: View {
  @Binding var selectedItem: Item?

  var body: some View {
    List {
      // List of items...

      Button(action: {
        self.selectedItem = item
      }) {
        Text(item.name)
      }
    }
  }
}
```


### SwiftUI preferences system | `.preference` & `.onPreferenceChange`:
It's a way to to send data only reverse direction, from child to parent (`@Binding` is 2 directional).  

```swift
import SwiftUI

/*
 here preference key is used to update parents state
 from the child
 the .preference modifier call on the child's text view
 will setup the observation on the text @State
 and updating that will be listen on the parent using .onPreferenceChange
 */

struct MyPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct PreferenceOnButtonPress: View {
    @State private var topLevelText: String = "Initial Text Top Level"
    
    var body: some View {
        VStack {
            Text("topLevelText: \(topLevelText)")
            ChildView(text: "Old Text For Child")
        }
        .onPreferenceChange(MyPreferenceKey.self) { newValue in
            print("Preference updated: \(newValue)")
            topLevelText += newValue // adding all text
            // topLevelText = newValue
        }
    }
}

struct ChildView: View {
    @State var text: String
    var body: some View {
        VStack {
            Text(text)
             .preference(key: MyPreferenceKey.self, value: text)
            // multiple preference can be used for final equation for each View
            Button("Update Preference") {
                text = "\(Int.random(in: 1..<100))"
                print("Updating from child")
            }
        }
    }
}

#Preview {
    PreferenceOnButtonPress()
}
```

https://medium.com/@fatihcyln/what-is-preferencekey-in-swiftui-3a3f0056b147


### `some View` opaque type:
`some` will enforce the return type of a function must be a single concrete type. Like Int and String both are `Equatable`, but when a function's expected return type is `some Equatable`, all conditional return must be a same type.

https://stackoverflow.com/questions/56433665/what-is-the-some-keyword-in-swiftui

```swift
struct TestSome {
    func foo(_ x: Int) -> some Equatable {
        if (x > 10) {
            return x
        } else {
            return 0
            // return ""
            // returning different type (Int or String) is not allowed when return type is prefixed with `some`
            // though both Int and Stirng are equatable
            // `some` will enforce all the return must be of same type
        }
    }
    
    func foo(_ x: Int) -> any Equatable {
        if (x > 10) {
            return x
        } else {
             return "" // allowed with `any` prefixed but can introduce bugs
        }
    }
}
```

### `.self`, `.type` | Swift Meta-types:
https://swiftrocks.com/whats-type-and-self-swift-metatypes