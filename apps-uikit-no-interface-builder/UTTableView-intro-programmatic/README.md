### UITableView using programmatic way:
Opting-out `interface-builder` and using the Programmatic UIKit needs initial project setup. 

- Delete `main.storyboard`
- From Project `General` ’s Targets select the app, then remove `Main` form the `Main interface` slot has
- From `info.plist` delete `Storyboard Name` row (the project’s search functionality can also be used by searching for `main` and deleting that)
- Set `window` & `window?.windowScene` and `window?.rootViewController` after the `guard let windowScene`  and call `window?.makeKeyandVisible()` inside SceneDelegate
    - window = UIWindow(frame: windowScene.coordinateScene.bounds)
    - window?.windowsScene = windowScene
    - window?.rootViewController = MyViewController() // instantiate your view controller
    - window?.makeKeyAndVisible()

### UITableView: