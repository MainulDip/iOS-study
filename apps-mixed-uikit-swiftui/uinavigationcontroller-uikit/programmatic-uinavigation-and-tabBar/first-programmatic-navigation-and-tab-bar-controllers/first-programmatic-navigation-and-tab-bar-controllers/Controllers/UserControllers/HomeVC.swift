//
//  HomeVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

class HomeVC: UIViewController {
    
    lazy var goToProfileBtn: UIButton = {
        let button = navButton(target: self, title: "Go to Detail", actionHandler: #selector(goToProfile))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
}


// MARK: Layout Setup
extension HomeVC {
    private func setupLayout() {
        view.addSubview(goToProfileBtn)
        centerXYToParent(view: goToProfileBtn, parentView: view)
    }
}

// MARK: Button Handlers
extension HomeVC {
    
    @objc func goToProfile() {
        navigationController?.pushViewController(DetailVC(), animated: true)
    }
}
