//
//  ViewController.swift
//  NotificationCenter-Observer-Intro
//
//  Created by Mainul Dip on 5/17/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .orange
        viewModel = .init()
    }

    @objc func buttonTappedForDark(_ sender: UIButton) {
        let name = Notification.Name(K.NotificationKeys.darkNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    @objc func buttonTappedForLight(_ sender: UIButton) {
        let name = Notification.Name(K.NotificationKeys.lightNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }

}

