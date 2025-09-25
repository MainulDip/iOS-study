### GCD Topics:
- DispatchGroup
- Semaphore
- Dispatch Barrier
- DispatchIO
- DispatchWorkItem (Cancellable Tasks)
- DispatchSource.makeTimerSource(:queue) for Dispatch Timers (NSTimer Upgrade)

### Asynchronous Tasks and Threading Overview:
Start with 
- GCD (Grand Central Dispatch) > Semaphore
- Async & Await
- Actors
- Concurrency With Combine
- Deadlocks


### Resources:
GCD - https://ios-dev-dilip-kumar.medium.com/mastering-grand-central-dispatch-in-swift-part-1-cc4b93bd80da
    - complete the 5 chapter 
        - Concurrency Basics and GCD Fundamental
        - Queue Types, Prioritization, and QoS
        - Task Coordination with Groups, Semaphores, and Barriers
        - Advance GCD Patterns (Sources, Work Items, and I/O)
        - GCD in Modern Swift: Bridging to async/await and Actors

### Before GCD and Why:
Thread or NSThread are used, but was difficult to manage threads manually

GCD was built to solve
- Race Condition | when 2 threads modifying the same data (will crash the app)
- Deadlocks | one thread is waiting for another thread forever
- Complexity Overload: debugging was harder because of the maze of locks and @synchronized

### Grand Central Dispatch (GCD) Intro (Theory):
Dispatch Queue: An object responsible for managing (concurrent) the execution of task/s relying on systems thread management (from a thread pool dedicated for task execution)

Queue Executes tasks as First-in-First-out to start the execution, 2 types, 1. `Serial` and 2. `Concurrent`. Each of them can be either `Synchronous` or `Asynchronous`
- Serial Queue: Does not start another task until the current task is finished
    - Synchronous Serial Queue: caller code waits until the task is finished 
    - Asynchronous Serial Queue: caller code doesn't wait
- Concurrent Queue: Start a task without waiting for the previous task to complete.
    - Synchronous Concurrent Queue:
    - Asynchronous Concurrent Queue:

There is another most important queue 
- The Main Queue: It's a serial queue, its responsible for UI-related task. 

    - Though Main Queue will always run on the `Main Thread`, Other queue can also use the main thread (sometimes) for code execution
    - To check, add a breakpoint to UI related code and run `po Thread.isMainThread` in the xcode console  

Global queues and Quality of Service
- GCD provides with some `Global` queue (Global queues are concurrent queue) to use easily based on 6 different QoS. QoS is to set task-priority. From top to bottom those are (priority wise)
 
 1. .userInteractive | for UI related task that needs instant result
 2. .userInitiated
 3. .default | when no QoS is mentioned
 4. .utility | calling api
 5. .background | task that doesn't require immediate feedback, ie, backups to the cloud
 6. .unspecified | don't use this QoS, its for legacy support 

 Custom/Private dispatch queue (only way to make a serial queue)
 - As global queues are concurrent, if we need some task to execute in `serial` queue at the same time not blocking Main queue, we have to create our own custom/private serial dispatch queue.
    - but creating custom/private dispatch queue will increase `thread` consumption. To avoid this, we can create this by delegating the task to a global queue and still utilize the serial queue features.

* Note: `serial` queue (custom) is to eliminate `data race` by executing write and read on the same `serial` queue

### GCD | usages of QoS (Quality of Service):
When not specified, The default QoS is .default, which sits between .utility and .userInitiated.
```swift
// 1. Main Queue (Serial) – For UI updates  
DispatchQueue.main.async {  
    self.updateLabel("Hello, World!")  
}  

// 2. Global Queues (Concurrent) – For heavy lifting  
DispatchQueue.global(qos: .background).async {  
    self.processDataInBackground()  
}

// 3. A function with like real-world usages 
func generateReport() {  
    // Show loading spinner (main thread)  
    showLoadingSpinner()  

    // Offload work to the background  
    DispatchQueue.global(qos: .userInitiated).async {  
        let report = createMassivePDF()  

        // Back to main queue for UI updates  
        DispatchQueue.main.async {  
            hideLoadingSpinner()  
            displayPDF(report)  
        }  
    }  
}
```


### `.sync` | Usages of Synchronization | DispatchQueue.<queue>.sync:
If a `.sync` is called from and on the same queue, it will create a deadlock and will crash the app.
```swift
// will cause a deadlock and crash the app
// running from main thread (main queue is run on main thread)
print("On main thread")
DispatchQueue.main.sync {
  print("The main thread is used by main queue")
}
// crashed by deadlock
// as the code runner here is the main thread, & .sync is call on the same main queue (main queue is always run on main thread)
// the .sync here can never execute, its blocking the runner itself

// Example 2
print("On main thread")
let serialQueue = DispatchQueue(label: "serialQueue")
serialQueue.async {
    serialQueue.sync {
        print("On custom serialQueue")
    }
}
// this will also crash
// .sync call from same queue and on same queue will cause deadlock
```

Good usages of `.sync`
```swift
print("Main thread and main queue")  // 1
DispatchQueue.global().sync {  //2
  print("global queue")  //3
}  //4
print("Main thread and main queue again")  //5
// this is ok, as .sync is called from main thread/queue on another queue
```
https://medium.com/@pm74367/demystifying-dispatchqueue-main-sync-9b86526e954b


### GCD Custom Queue | Serial and Concurrent:
`label` initializer is used to create custom queue, `DispatchQueue(label: "CQ", attribute: <.concurrent or .serial>)`

Custom serial queue is good for
- Writing to a file (avoiding simultaneous writes)
- Syncing access to shared resources (like databases)

Custom concurrent queue is good for 
- Processing multiple images simultaneously
- Running independent network requests in parallel

```swift
// custom serial queue  
let serialQueue = DispatchQueue(label: "com.dilip.serialQueue")  

serialQueue.async { print("Task 1") }  
serialQueue.async { print("Task 2") }  
// Output: "Task 1" → "Task 2" (guaranteed order!)

// custom concurrent queue  
let concurrentQueue = DispatchQueue(  
    label: "com.dilip.concurrentQueue",  
    attributes: .concurrent  
)  

concurrentQueue.async { run("Task 1") }  
concurrentQueue.async { run("Task 2") }  
// Output: Order not guaranteed (could be Task 2 → Task 1).
```
### `concurrentPerform(:Int)` | for tons of concurrent task:
If too many concurrent queue are created, the app can be lag, because GCD needs to create more thread for concurrent queue task

To perform tons of concurrent task, `DispatchQueue.concurrentPerform(:iterations)` is more performant

```swift
// Process 1000 images efficiently  
DispatchQueue.concurrentPerform(iterations: 1000) { i in  
    processImage(at: i) // GCD auto-manages threads!  
}
```


### Fix/Prevent `race-condition`:
```swift
for _ in 0...100 {  
    DispatchQueue.global().async {  
        self.updateCounter() // 😱 Race condition chaos!  
    }  
}
// 100 of command trying to update a prop at a nearly same time
```

### GCD Groups | Notify callback after task finishes:
Dispatch Groups is to track multiple tasks and trigger a callback when they're all finished using. The workflow is
    - create the group : `let group = dispatchGroup()`
    - mark entering by `group.enter()`
    - mark leaving by `group.leave()`
    - finishing callback by `group.notify(queue: <Queue>){}`

Note: There should be the pair of `enter` and `leave` call. If mismatched. Too many `leave` will crash the app, less will put on a hanging state.


Example: Loading 3 API endpoints before updating app's dashboard

```swift
func loadDashboardData() {  
    let group = DispatchGroup()  

    // Task 1: Fetch user profile 
    // mark `entering` usually from outer-scope and just before of a task completion function call
    group.enter()  
    fetchUserProfile {  
        // call `leave` after the task, usually last call of a functions inner-scope
        group.leave()  
    }  

    // Task 2: Fetch latest posts  
    group.enter()  
    fetchPosts {  
        group.leave()  
    }  

    // Task 3: Fetch notifications  
    group.enter()  
    fetchNotifications {  
        group.leave()  
    }  

    // Notify when all tasks are done  
    group.notify(queue: .main) {  
        self.showDashboard()  
    }  
}
```

### (* need more) GCD Semaphore | Limit control for concurrent task by limiting number of thread use:
Semaphores control access to shared resources by limiting how many threads can use them at the same time.


Note: Need more in-depth understanding along with note


Example: Prevent 100 simultaneous network calls from overwhelming your server.

```swift
let semaphore = DispatchSemaphore(value: 3) // Allow 3 concurrent tasks  

func downloadVideo(url: URL) {  
    semaphore.wait() // ⛔️ “Wait if there are already 3 tasks”  
    DispatchQueue.global().async {  
        defer { semaphore.signal() } // ✅ “I’m done! Next in line!”  
        // Perform the video download  
    }  
}
```

### (* need more) GCD Barriers | task's exclusive access | works on custom concurrent queues:
Barriers act as checkpoints in a concurrent queue. They ensure that a specific task gets exclusive access, with no other tasks running at the same time. Usually called by `<customConcurrentQueue>.async(flags: .barrier)` 

Used for `Thread safe data caching`

```swift
let concurrentQueue = DispatchQueue(label: "com.you.cacheQueue", attributes: .concurrent)  
private var cache: [String: Data] = [:]  

func safeWrite(_ data: Data, for key: String) {  
    // Exclusive write access 🔒  
    concurrentQueue.async(flags: .barrier) {  
        cache[key] = data  
    }  
}  

func safeRead(for key: String) -> Data? {  
    // Concurrent read access 🔓  
    var data: Data?  
    concurrentQueue.sync {  
        data = cache[key]  
    }  
    return data  
}
```

Note: Need more in-depth understanding along with note

### (* need more) GCD DispatchIO | Efficient file read instead of the main thread:
Reading large files on the main thread? That’s a performance killer. Dispatch I/O allows chunked reading, preventing memory bloat and UI freezes.

```swift
func readLargeFile(url: URL) {  
    let channel = DispatchIO(
        type: .stream,  
        fileDescriptor: open(url.path, O_RDONLY),  
        queue: DispatchQueue.global(),  
        cleanupHandler: { error in
            if error != 0 { print("Error reading file") }  
        }  
    )  

    var data = Data()  
    channel.read(offset: 0, length: Int.max, queue: DispatchQueue.global()) { done, chunk, error in  
        guard let chunk else { return }  
        data.append(chunk)  
        if done {  
            DispatchQueue.main.async {
                print("File read successfully")
            }
        }  
    }  
}
```

### DispatchWorkItem and DispatchSource


### GCD DispatchWorkItem for Cancellable Tasks:
Background tasks can now be cancelled mid-execution. This is particularly useful for debouncing user input, like in a search bar.

```swift
var searchWorkItem: DispatchWorkItem?  

func searchTextChanged(_ text: String) {  
    searchWorkItem?.cancel()  

    let newWorkItem = DispatchWorkItem {  
        fetchSearchResults(text)  
    }  

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: newWorkItem)  
    searchWorkItem = newWorkItem  
}
```

### GCD Timers | Scheduling :
GCD timer are lightweight, thread-safe, amd more flexible than NStimer. They don't depend on run loops, making them perfect for background scheduling. 

```swift
func startCountdown (from  seconds: Int) {
    let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    val count = seconds

    timer.schedule(deadline: .now(), repeating: 1.0) // will fire on every second from now after resume() is called

    timer.setEventHandler {
        DispatchQueue.main.async {
            print("Time left: \(count) seconds")
        }
        count -= 1
        if count < 0 {
            timer.cancel()
        }
    }

    timer.resume()
}
```

### GCD to Async/Await Ex 1:
`DispatchQueue.main.async` in GCD is kinda same as `MainActor.run` in the Async/Await
```swift
func loadUserDataGCD() {  
    DispatchQueue.global().async {  
        fetchUser { user in  
            DispatchQueue.main.async {  
                self.updateUI(user)  
                DispatchQueue.global().async {  
                    fetchPosts(user.id) { posts in  
                        DispatchQueue.main.async {  
                            self.showPosts(posts)  
                        }  
                    }  
                }  
            }  
        }  
    }  
}

func loadUserDataAsyncAwait() async {  
    // 1. Fetch user (background thread)  
    let user = await fetchUser()  

    // 2. Update UI (main thread)  
    await MainActor.run {  
        self.updateUI(user)  
    }  

    // 3. Fetch posts (background thread)  
    let posts = await fetchPosts(user.id)  

    // 4. Show posts (main thread)  
    await MainActor.run {  
        self.showPosts(posts)  
    }  
}
```

### GCD vs Async/Await And Actor:
Actors eliminate race conditions without locks, semaphores, or barriers. Let’s compare

Note: Usages of `Actor` replaces `lock/barriers`

* GCD to Async/Await Conversion

```swift
// Using GCD
class CacheGCD {  
    private var storage = [String: Data]()  
    private let queue = DispatchQueue(label: "cache.queue", attributes: .concurrent)  

    func set(_ data: Data, for key: String) {  
        queue.async(flags: .barrier) {  
            self.storage[key] = data  
        }  
    }  
}

// Using Actor and Async/Await
actor Cache {  
    private var storage = [String: Data]()  

    func set(_ data: Data, for key: String) {  
        storage[key] = data  
    }  

    func get(for key: String) -> Data? {  
        storage[key]  
    }  
}
```

### GCD + Async/Await:
`await withCheckedContinuation {}` is for calling GCD based function inside Async/Await as a callback.

using `Task {}`, Async/Await functions can be run from inside of a GCD based function .......

ex: 1 | `await withCheckedContinuation {}` usages

```swift
// Old GCD function  
func fetchUserGCD(completion: @escaping (User) -> Void) {  
    DispatchQueue.global().async {  
        let user = // ...  
        completion(user)  
    }  
}  

// Modern async wrapper  
func fetchUserAsync() async -> User {  
    await withCheckedContinuation { continuation in  
        fetchUserGCD { user in  
            continuation.resume(returning: user)  
        }  
    }  
}
```

* Ex: 2 | Async Code Inside GCD Queues using `Task {}`

```swift
DispatchQueue.global(qos: .userInitiated).async {  
    Task {  
        let data = await fetchData()  
        await MainActor.run { self.label.text = data }  
    }  
}
```

### Data Race and `Thread Sanitizer, aka TSan`:
Thread Sanitizer is an LLVM (low level virtual machine) based tool to audit threading issues in Swift and C language written code, introduced in xcode 8

* Data Race Condition: When same memory is accessed from multiple threads without synchronization, and at least one access is a write. 

```swift
private var name: String = ""

func updateName() {
    DispatchQueue.global().async {
        // executed on the background thread
        self.name.append("NewName") // (1) write access
    }

    // Executed on the main thread
    print(self.name) // (2) read access
}

/*
As the Dispatch callback here is async and is also mutating a prop in the callback (* at least one write access), and printing from main thread afterward outside of Dispatch's scope, It's unpredictable if the write happens before read
*/
```
### Thread Sanitizer | TSan | Data Race Checking:
Enable Thread Sanitizer From `Product` > `Scheme` > `Edit Scheme` and From there `Run` > `Diagnostic` 

The compiler will add some code to check `data race` safety

```swift
func updateName() {
    DispatchQueue.global().async {
        self.recordAndCheckWrite(self.name) // Added by the compiler
        self.name.append("NewName")
    }

    // Executed on the Main Thread
    self.recordAndCheckWrite(self.name) // Added by the compiler
    print(self.name)
}
```

More on thread sanitizer : https://www.avanderlee.com/swift/thread-sanitizer-data-races/#using-the-thread-sanitizer-to-detect-data-races

### Solving `Data Race` Using GCD:
Using `serial` queue, and assign both write/read to it will ensure the sequentiality of those tasks (first gets executed and completed first before seconds starts), hence eliminating `data race`

```swift
// creating a custom queue to use as serial queue (default)
private let lockQueue = DispatchQueue(label: "name.lock.queue")
private var name: String = ""

func updateNameSync() {
    DispatchQueue.global().async {
        self.lockQueue.async {
            // Executed on the lock queue (serial queue)
            self.name.append("NewName")
        }
    }

    // Executed on the Main Thread
    lockQueue.async {
        // Executed on the lock queue (serial queue)
        print(self.name)
    }
}

// Prints:
// Antoine van der Lee
// Antoine van der Lee
```

### Solving `Data Race` Using Actor and Async/Await:

```swift
actor NameController {
    private(set) var name: String = "My name is: "
    
    func updateName(to name: String) {
        self.name = name
    }
}

func updateName() async {
    DispatchQueue.global(qos: .userInitiated).async {
        Task {
            await self.nameController.updateName(to: "Antoine van der Lee")
        }
    }
    
    // Executed on the Main Thread
    print(await nameController.name)
}
```

### Actor in-depth ( eliminate data race ):
Actor is like a `class` (reference type) in swift, but doesn't support inheriting other actor/s, can be used with protocol and generics. 

All properties (`var/mutable`) and methods inside of an Actor is `isolated` by default. `Methods` and `Computed` properties can be marked with `nonisolated var/func` when they are accessing/reading only immutable prop/s. Constant (`let`)  properties are `nonisolated` (prefixing is redundant for let)

* To access a property/method on actor's instance, `await` is required to write before the call. This ensure's the read/write synchronization chain, so nothing gets access to the prop at the same time, eliminating `data race`. 

* Class using the DispatchQueue (not using Actor/Async/Await)

```swift
final class ChickenFeederWithQueue {
    let food = "worms"
    
    /// A combination of a private backing property and a computed property allows for synchronized access.
    private var _numberOfEatingChickens: Int = 0
    var numberOfEatingChickens: Int {
        queue.sync {
            _numberOfEatingChickens
        }
    }
    
    /// A concurrent queue to allow multiple reads at once.
    private var queue = DispatchQueue(label: "chicken.feeder.queue", attributes: .concurrent)
    
    func chickenStartsEating() {
        /// Using a barrier to stop reads while writing
        queue.sync(flags: .barrier) {
            _numberOfEatingChickens += 1
        }
    }
    
    func chickenStopsEating() {
        /// Using a barrier to stop reads while writing
        queue.sync(flags: .barrier) {
            _numberOfEatingChickens -= 1
        }
    }

}
```

* Actor usages instead of DispatchQueue and Barrier

```swift
actor ChickenFeeder {
    let food = "worms"
    var numberOfEatingChickens: Int = 0
    
    func chickenStartsEating() {
        numberOfEatingChickens += 1
    }
    
    func chickenStopsEating() {
        numberOfEatingChickens -= 1
    }
}

let feeder = ChickenFeeder()
await feeder.chickenStartsEating
await feeder.numberOfEatingChickens
```


### Preventing unnecessary `Suspension`:
calling `await` on each isolated prop/method creates a suspension point to wait for access (like serial queue). So when there are some chain of work, that can be done form inside the actor minimizing `await` call from outside, it will be more performant. 

```swift
actor ChickenFeeder {
    let food = "worms"
    var numberOfEatingChickens: Int = 0
    
    func chickenStartsEating() {
        numberOfEatingChickens += 1
        notifyObservers()
    }
    
    func notifyObservers() {
        NotificationCenter.default.post(name: NSNotification.Name("chicken.started.eating"), object: numberOfEatingChickens)
    }
}

// Instead of 2 await call for 2 different functions
// include the both related function to one and call by single await
let feeder = ChickenFeeder()
await feeder.chickenStartsEating()
```

### MainActor and Global Actors:
Global Actors are `named` actor that is accessible globally. If you define your own global actor, you can access that particular actor by that name globally throughout your app.

`MainActor` is a special kind of (named) global actor already available, will run on the `Main Thread`.......


* Note: Only the `@MainActor` is guaranteed to be run on the main thread. For all other actors, its the non-main thread.

By annotating an Actor with `@globalActor` and providing a singleton with a `shared` property, ie `static let shared = CustomGlobalActor()`, will make it available to use globally.
Any actor annotated with `@globalActor` attribute automatically conform to the `GlobalActor` protocol. 

### GCD Checklist:
Working with dispatch queue and task
    - Dispatch Queue
    - Dispatch Work Item
    - Dispatch Group
    - Workloop
Thread Scheduling
    - DispatchQos (QoS = Quality of service)
System Event Monitoring
    - Dispatch Source
    - Dispatch I/O
    - Dispatch Data
Task Synchronization
    - Dispatch Semaphore
    - Dispatch Barrier

### Update Data In TableView:
To update data inside tableView, there is a function to reload data
```swift
// update the table view, also DispatchQueue to be extra safe side to confirm the background thread is synced into main thread
// when from `DispatchQueue.global` queues
DispatchQueue.main.async {
    self.tableView.reloadData()
}
```

### Concurrency Helper Function:
`Task.sleep()`
`Task.yield()`

Thread sleep, Blocking (not for suspending) 
`sleep()` and `Thread.sleep()`

Non blocking
`Timer.scheduledTimer(:withTimeInterval:repeats)`
`DispatchQueue.main.asyncAfter()`

### Todo
=> Find way like `thread sleep` to emulate concurrent behavior
=> Find what available for like `thread sleep` on both sync and async 