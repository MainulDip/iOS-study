## Overview:
Jump starting guide on Local Storage and Persistance Storage etc

### AppDelegate lifecycle Methods and App Cache Lifecycle:
- applicationDidEnterBackground :
- applicationWillTerminate: call last when cleared by os or manually form background. All cached app data will be destroyed.
### UserDefaults (Persistent Local Data Storage):
- UserDefaults save data as "plist" file.
- Not good for big data (Slow because ios need to search and load all the local plist file), so better Only store small data (few KBs)
- Its not a database replacement
```swift
var itemArray = ["Yoo", "World", "BlaBla"]

// initialize the UserDefaults Local Storage
let defaults = UserDefaults.standard

// on viewDidLoad read local storage data
if let items = defaults.array(forKey: "TodoListArray") as? [String] {
    itemArray = items
}

// populate local storage with updated data
itemArray.append("New BlaBla")
defaults.set(self.itemArray, forKey: "SomeKey")
```
- the saved plist file can be found following the output directory by
```swift
// inside AppDelegate's application:didFinishLaunchingWithOptions
print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
```

### Singleton in Swift:
- Kinda same as Java and other programming languages, use static property to initialize and get the object