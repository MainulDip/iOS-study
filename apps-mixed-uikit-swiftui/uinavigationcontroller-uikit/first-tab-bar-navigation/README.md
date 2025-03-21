### Initial Setup Storyboard:
Embedding a ViewController in `Tab Bar` will do the magic. To further add new controller as one of the `Tab Bar` item, `ctrl + drag` and select `relationship segue`.

To set a UINavigation Controller as one of the Tab-Bar's item > First embed a (separate) ViewController into UINavigationController > then the same `ctrl + drag` from the `Tab Bar` Controller to `UINavigationController`. 

### Setting Icons Storyboard:
As all VCs are mapped into `Tab Bar` Controller, each VC (Scene) will get an new entry (same level as `view`) to set it's `Tab Bar Item` section inside `Identity Inspector`. 

### Position Rearrangement:
Storyboard : Zoom into the `Tab Bar Controller` Scene's items and Drag left/right item to reposition.

### Changing Icons color:
Storyboard > [Tab Bar Controller] Scene > [Tab Bar Controller] > Tab Bar > `identity inspector` > `User Defined Runtime Attribute` > add new values


- Color for selected item > KeyPath: `tintColor` | (Type) Color | (Value) ...
- Color For UnSelected Item > KeyPath: `tintColor` | (Type) Color | (Value) ...

For changing colors programmatically, go to AppDelegate.swift and set desired color
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().unselectedItemTintColor = .red
        return true
    }
```


### Left/Right Scrollable Bottom Tab Bar Item: