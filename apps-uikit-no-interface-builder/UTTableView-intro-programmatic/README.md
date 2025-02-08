### UITableView using programmatic way:
Opting-out `interface-builder` and using the Programmatic UIKit needs initial project setup. 

- Delete `main.storyboard`
- From Project `General` ’s Targets select the app, then find `Deployment Info` > `supports multiple windows` > `Custom ios target properties` remove `Main` entry of the `Main Storyboard
- From `info.plist` delete `Storyboard Name` row (the project’s search functionality can also be used by searching for `main` and deleting that)
- Set `window` & `window?.windowScene` and `window?.rootViewController` after the `guard let windowScene`  and call `window?.makeKeyandVisible()` inside SceneDelegate

```swift
guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
```

### UITableView: