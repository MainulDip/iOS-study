### VIPER | View Interactor Presenter Entity Router:
View: ViewController (UI code)
    - hold reference for `Presenter` and `Router`
Interactor: Interact with Presenter for Network call
    - hold reference for `Presenter`
Presenter: Presents data to View (as Interactor supplies)
    - hold reference for `View`, `Interactor` and `Router`
Entity: Model structs live here
Router: is the entry point, SceneDelegate will access View through this
    - create it's own instance (static) and all other (VIP) instances
    - inject/supply the all the delegates of each other
    - expose reference for `View` and It's own instance

### VIPER Workflow:
Other than Entity, all other class's protocol are defined first. It works like a `Delegation` pattern. When a class needs to access other classes, it usage other classes defined as that's protocol type within its own properties.

All protocols are defined first, then other class will conform its own type

```swift
protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func update(with users: [User])
    func update(with error: String)
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getUser()
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

protocol AnyRouter {
    // var view: AnyView & UIViewController { get }
    typealias EntryPoint = AnyView & UIViewController
    var entryPoint: EntryPoint? { get }
    static func start() -> AnyRouter
}
```