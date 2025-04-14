//
//  ViewController.swift
//  GCD-InDepth-First-UIKit
//
//  Created by Mainul Dip on 4/7/25.
//

import UIKit

class ViewController: UIViewController {
    
//    private let vm = ViewModel()
    private var vm: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .orange
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
            DispatchQueue.main.async { [weak self] in
                self?.view.backgroundColor = .green
            }
        })
        
        Task {
            // print(Thread.isMainThread)
            self.vm = await ViewModel()
            
        }
        
        
        print("called viewDidLoad")
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func applicationWillEnterForeground() {
        print("applicationWillEnterForeground")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("called viewWillAppear")
    }

}

