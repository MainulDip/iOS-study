//
//  DetailVC.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//

import UIKit

class DetailVC: UIViewController {
    
    lazy var buttonAsTitle: UIButton = {
        let button = navButton(target: self, title: "Detail ViewController", actionHandler: #selector(logHello))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        title = "Detailed View"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupLayout()
    }
}

// MARK: Setup Layout
extension DetailVC {
    private func setupLayout() {
        view.addSubview(buttonAsTitle)
        centerXYToParent(view: buttonAsTitle, parentView: view)
    }
}

// MARK: Button Handlers
extension DetailVC {
    @objc func logHello() {
        print("Hello from DetailVC!")
    }
}
