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

### Grand Central Dispatch (GCD) Intro:
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
DispatchQueue.main.async {
    self.tableView.reloadData()
}
```