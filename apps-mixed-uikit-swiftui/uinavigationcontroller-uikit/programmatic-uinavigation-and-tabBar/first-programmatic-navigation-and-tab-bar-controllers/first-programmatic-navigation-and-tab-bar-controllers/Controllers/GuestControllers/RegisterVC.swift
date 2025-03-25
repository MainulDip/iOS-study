//
//  RegisterVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

class RegisterVC: UIViewController {
    
    lazy var registerButton: UIButton = {
        let button = navButton(target: self, title: "Registration Done", actionHandler: #selector(handleRegistration))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
}


// MARK: Layout Setup
extension RegisterVC {
    private func setupLayout() {
        view.addSubview(registerButton)
        centerXYToParent(view: registerButton, parentView: view)
    }
}


// MARK: Button Press Handelers
extension RegisterVC {
    @objc func handleRegistration() {
    
        print("Registration Complete, Login Now")
        tabBarController?.selectedIndex = 0
    }
}
