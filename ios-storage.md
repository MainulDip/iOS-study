## Overview:
Jump starting guide on Local Storage and Persistance Storage etc
- UserDefaults
- KeyChain
- NSCoder/Codable
- CoreData/Sqlite
_ Realm (OpenSource/Trending)

### AppDelegate lifecycle Methods and App Cache Lifecycle:
- applicationDidEnterBackground :
- applicationWillTerminate: call last when cleared by os or manually form background. All cached app data will be destroyed.
### UserDefaults (Persistent Local Data Storage) [Todo App]:
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

### iOS Storage File Inspection:
- get the file path
- navigate using terminal | cd / (will point to the root) | cd ~ (will point to home dir)
- use "open ." to open in macos finder app

### Singleton in Swift:
- Kinda same as Java and other programming languages, use static property to initialize and get the object.

### Storing Custom Objects Using NSCoder [Todo App]:
To store custom objects UserDefaults show it's limitation. As UserDefault store data as property lists (key value pair dictionary), any object besides form built in types need the NSCoder Route.

To Use NSCoder to store custom objects into the plist file, we need
- define the url using FileManager, where the data will be stored, and get the handle
- encode the data with PropertyListEncoder and save the encoded data to the url location
- decode the stored data with PropertyListDecoder, the model structure/type and the stored filePath needs to be supplied

```swift
class TodoListViewController: UITableViewController {
    
    var itemArray: [Item] = []
    
    // define the file which will be used to store data
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get local data and update the local list using generics
        if let url = dataFilePath {
            let sth: [Item] = decodeItemDataGenerics(filePath: url)
            itemArray = sth
        }
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {

        // using NSCoder
        self.encodeAndStore(localData: self.itemArray, filePath: self.dataFilePath!)
        
        
        // reload the tableView
        self.tableView.reloadData()

    }
    
    // MARK - Custom NSCoder Encoder and Decoder Function
    
    func encodeAndStore(localData: Encodable, filePath: URL) {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(localData)
            try data.write(to: filePath)
            
        } catch {
            print("Custom PropertyList Encoder: ", error)
        }
    }
    
    func decodeItemData (fitePath: URL) {
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: fitePath)
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Decoder Error: ", error)
        }
    }
    
    // over-engineering using generics
    func decodeItemDataGenerics<T: Decodable> (filePath: URL) -> [T] {
        let decoder = PropertyListDecoder()
        var storedItemArray: [T] = []
        
        do {
            let data = try Data(contentsOf: filePath)
            storedItemArray = try decoder.decode([T].self, from: data)
        } catch {
            print("Decoder Error: ", error)
        }        
        return storedItemArray
    }    
}
```
### Storage with CoreData:
- Adding CoreData:
 - add new file, select CoreData Section's Data Model
 - add all the AppDelegate functions for CoreData, NSPersistentContainer name should match with the newly created DataModel filename. (Don't forget to add/import the CoreData package)

* CoreData Terms:
- Entity (Class)
- Attributes (Property)
- Entities are table of data