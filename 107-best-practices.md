### code organization and use of class/struct `extension`:
when a ViewController gets long
- the initial class declaration should contain only stored properties and property observers. As `extension` can not contain stored and property observers `willSet/didSet`
- use `// MARK: <identification-comment>` before stored properties declaration, try to make similar properties live together.
- maintain same order of placement for related methods (linked with the properties) in the `extension`
- use separate extension to override methods for conforming protocol
- place `viewDidLoad` on the initial class or together with `viewWillTransition` in a separate extension

Get some extra quick code navigation from xcode's quick jump bar
```swift
// MARK: - This will show a line separator 
// TODO: Some Text
// FIXME: Some Text
```

### API keys:
Always store them in the server
For client do - `obfuscation`

### Swift Concurrency:
https://www.massicotte.org/concurrency-glossary.......

### Indi app developer case study:
https://swiftrocks.com/things-that-did-and-didnt-contribute-to-burnout-buddys-success.......

### API Key Managements for Development Phase:
For development phase, its same for all, create the Env file and put that into the gitignore.

For iOS, create a property file `.plist` in xcode, add `.gitignore` entry for those files, assign Key:Value for api key/s, and query them from the swift code
    - build the file path targeting the plist file
        - `Bundle.main.path(forResource: resourceName, ofType: "plist")`
    - and use that file path to build the `NSDictionary` like Set<String>
        - `NSDictionary(contentsOfFile: filePath)`


Structured Way: Same approach can be used for `secret key` management for publishing app store apps
* From `Product` > `Scheme` > `Edit Scheme` changing the build configuration to `Release` will make the compiler argument `DEBUG` to false.

```swift
@main
struct Combine_Networking_Basics_3ndApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(ENV.API_Key)
                }
        }
    }
}

var ENV: APIKeyable {
    #if DEBUG
    return DebugEnv()
    #else
    return ProdEnv()
    #endif
}


class BaseEnv {
    let dict: NSDictionary
    
    init(resourceName: String){
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
        let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find resource file as \(resourceName).plist")
        }
        self.dict = plist
    }
}

protocol APIKeyable {
    // write all required API keys property here
    // whenever you wanna include a new api key into the project 
    // update this protocol, and all other classes conforming to this protocol will throw error, so filling the requirements will be much easier
    var API_Key: String { get }
}

class DebugEnv: BaseEnv, APIKeyable {
    var API_Key: String {
        dict.object(forKey: "TMDB_API_Key") as! String
    }
    
    init() {
        super.init(resourceName: "Debug-keys")
    }
}

class ProdEnv: BaseEnv, APIKeyable {
    var API_Key: String {
        dict.object(forKey: "TMDB_API_Key") as! String
    }
    
    init() {
        super.init(resourceName: "Prod-keys")
    }
}
```


### API Key Managements Secured/Production Phase:
For apps those are intended to be published into app store, API key should never be stored into publicly available App's file. The should be stored into backend server, and app should use a bunch of secret keys as rotation. Never include your API keys in published apps