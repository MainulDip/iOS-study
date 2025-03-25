//
//  ViewController.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/21/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }

    // TODO: Sequential
    /*
     - set window.rootViewContrller = UINavigationController(rootViewController: VC())
     - make a button on the VC's view (auto layout)
     - Make another VC
     - and on button press, `present that controller`
     - self.navigationController?.pushViewController(destinationVC(), animated: true)
     */
}

// TODO: TabBar Setup
/*
 - create a VC and conform to UITabBarController
 - create bunch of  VC class and instantiate them from TabBar custom class
 - each VC has a `tabBar`, set its image, title, prop for icon
 - the `TabBarViewController` has a `setViewControllers([VC],..) function which will connect the Tab Bar Item
 - finnally set the SceneDelegate's rootViewController as the TabBarController
 */

// TODO: TabBar - Load Different Tab Bar For LoggedIn and Guest User
/*
  - create a new class conformoing to UITabBarController, ie, GuestTabBarVC
 - create a func in SceneDelegate `func(VC)` that will set the self.window.rootViewController = pass-down-vc and call SceneDelegate's UIView.transition(window, ..,..) to perform flip transition animation
 - that func can be called using
    - (UiApplicaiton.shared.connectedScene.first?.delegate as? SceneDelegate)?.<Func-Of-SceneDelegate(VC)>
 */
