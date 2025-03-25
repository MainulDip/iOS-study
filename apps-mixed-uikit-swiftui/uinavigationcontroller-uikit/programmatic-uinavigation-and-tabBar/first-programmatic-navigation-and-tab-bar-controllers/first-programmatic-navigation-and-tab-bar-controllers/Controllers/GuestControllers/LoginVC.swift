//
//  LoginController.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//

import UIKit

class LoginVC: UIViewController {
    
    lazy var loginButton: UIButton = {
        let button = navButton(target: self, title: "Login", actionHandler: #selector(handleLogin))
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupLayout()
        print("First")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Second")
    }
}

// MARK: Layout SETUP
extension LoginVC {
    private func setupLayout() {
        view.addSubview(loginButton)
        centerXYToParent(view: loginButton, parentView: self.view)
    }
}

// MARK: Button Press Handlers
extension LoginVC {
    @objc func handleLogin() {
        print("Login button tapped")
        (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate as SceneDelegate).navigateTo(vc: UserTabBarVC())
    }
}
