### UINavigationController:
It's a container that holds/contain a viewController as a rootViewController (always) and include/pushes other viewController/s into its stack when navigation happened (segue/storyboard or programmatic)

### UINavigationController in Storyboard:
In storyboard, there is an option for a `controller` type to `embed in Navigation Controller`, which pushes that controller inside of an navigation controller and make it as the `rootViewController`. Using `Segue`, the navigation controller pushes new viewController/s on top of the rootViewController and pop if back button is pressed (stack, last come last out)

To add a new screen in story board, add a viewController UI from the interface  builder. Also create a file (ViewController) manually to attach the xml/storyboard controller view. 

* Setting a navigation
- `ctrl + drag` from a button (of a controller) to another controller, the storyboard will popup for segue, select `show` from there. NB: Modal is not a segue 

* Customizing navigation item's look:
Upon embedding into navigation controller and setting up segue, there will be a separate entry in storyboard left panel named `Navigation Controller Scene` and each `ViewController` will get an `Navigation Item` entry. 

- `Navigation Controller Scene` will hold the overall customization options and customization for the bar
    - `Large Title Text Attributes` section is important
    - inside `View` section, the `tint` represent the navigation title and `back` button color
- `Navigation Item` entry of the `ViewController`'s will get controller specific options, ie, `title`, `back button` customization, etc. 

- Note: programmatically set props will take precedence, thins those are set from storyboard will be ignored. 

NB: When setting a title or any test in storyboard, it requires pressing the `Enter` key to actually save that. Without pressing the `Enter` key, the changes are not applied

- Note: the back button customization option of a controller relies on back's destination `navigation item`  .......

### UINavigationController programmatic:
There is no segue in programmatic UI building.