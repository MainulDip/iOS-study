//
//  ProfileVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

class ProfileVC: UIViewController {
    
    lazy var logoutButton: UIButton = {
        let button = navButton(target: self, title: "Logout", actionHandler: #selector(logout))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title = "Something" // will override previouly set title form the UITabBarController
        setupLayout()
        
    }
}

// MARK: Setup Layout
extension ProfileVC {
    private func setupLayout() {
        view.addSubview(logoutButton)
        centerXYToParent(view: logoutButton, parentView: view)
    }
}


// MARK: Button Handelers
extension ProfileVC {
    @objc func logout() {
        print("Logging OUT")
        (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate as SceneDelegate).navigateTo(vc: GuestTabBarVC())
    }
}
