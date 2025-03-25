//
//  UserTabBarVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

class UserTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItemVCs()
    }
    
    private func setupTabBarItemVCs() {
        let homeVC = HomeVC() // NavigationController Item
        // let detailVC = DetailVC() // // NavigationController Item will be initialized from homeVC when pushing
        let profileVC = ProfileVC()
        let settingsVC = SettingsVC()
        
        
        // setup as tabbar item
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.fill"))
        
        setViewControllers([UINavigationController(rootViewController: homeVC), profileVC, settingsVC], animated: false)

    }
}
