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

 Custom/Private dispatch queue
 - As global queues are concurrent, if we need some task to execute in serial queue at the same time not blocking Main queue, we have to create our own custom/private serial dispatch queue.
    - but creating custom/private dispatch queue will increase `thread` consumption. To avoid this, we can create this by delegating the task to a global queue and still utilize the serial queue features.

### GCD | usages of QoS:
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

### GCD Groups:

### GCD Semaphore:

### GCD Barriers:

### GCD Timers:

### GCD File Watchers:

### GCD + Async/Await:

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