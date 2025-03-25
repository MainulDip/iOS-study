//
//  SettingsVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

class SettingsVC: UIViewController {
    
    lazy var goBackHomeBtn: UIButton = {
        let button = navButton(target: self, title: "Go Back Home", actionHandler: #selector(goBackHome))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
}

// MARK: Setup Layout
extension SettingsVC {
    private func setupLayout() {
        view.addSubview(goBackHomeBtn)
        centerXYToParent(view: goBackHomeBtn, parentView: view)
    }
}

// MARK: Button Handlers
extension SettingsVC {
    @objc func goBackHome() {
        tabBarController?.selectedIndex = 0
    }
}
