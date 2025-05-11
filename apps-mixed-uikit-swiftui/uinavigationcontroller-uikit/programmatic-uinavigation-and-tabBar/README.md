### UINavigationController Programmatic:
- set window.rootViewController = UINavigationController(rootViewController: VC()) inside SceneDelegate
- make a button on the VC's view (auto layout)
- Make another VC
- and on button press, `push that controller`
- self.navigationController?.pushViewController(destinationVC(), animated: true).......

```swift
extension HomeVC {
    @objc func goToProfile() {
        navigationController?.pushViewController(DetailVC(), animated: true)
    }
}
```


### UITabBarController Programmatic:
- create a VC and conform to UITabBarController
- create bunch of  VC class and instantiate them from TabBar custom class
- each VC has a `tabBarItem`, set its image, title, prop for icon
- the `TabBarViewController` has a `setViewControllers([VCs],..)` function which will connect the Tab Bar Item
- finally set the SceneDelegate's rootViewController as the TabBarController

### Load Different TabBar based on User LoggedIn/Out:
- create a new class conforming to UITabBarController, naming GuestTabBarVC
- create a func in SceneDelegate `func(VC)` that will set the self.window.rootViewController = pass-down-vc and call SceneDelegate's UIView.transition(window, ..,..) to perform flip transition animation.......

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {        
        // setup programmatic UI
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = GuestTabBarVC()
        // window.rootViewController = UserTabBarVC()
        self.window = window
        }
    
func navigateTo(vc: UIViewController) {
    guard let window = window else { return }
    window.rootViewController = vc
    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
}
```

- call the SceneDelegate's func using (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate as SceneDelegate)<Func-Of-SceneDelegate(VC)>

```swift
@objc func logout() {
    print("Logging OUT")
    (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate as SceneDelegate).navigateTo(vc: GuestTabBarVC())
}
```
### Navigating Between TabBarItems:
Each viewController has a prop `tabBarController` use that to navigate to another tab inside it's parent TabBar
`tabBarController?.selectedIndex = 0`