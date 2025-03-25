//
//  GuestTabBarVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

class GuestTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItemVCs()
    }
    
    private func setupTabBarItemVCs() {
        let loginVC = LoginVC()
        let registerVC = RegisterVC()
        
        loginVC.tabBarItem = UITabBarItem(title: "Login", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        registerVC.tabBarItem = UITabBarItem(title: "Register", image: UIImage(systemName: "square.and.arrow.up"), selectedImage: UIImage(systemName: "square.and.arrow.up.fill"))
        setViewControllers( [loginVC, registerVC], animated: false)
    }
}
