//
//  ViewController.swift
//  AdaptiveLayout-1
//
//  Created by Mainul Dip on 2/21/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myfunction()
    }

    func myfunction() {
        let traitsC = self.traitCollection
        print(traitsC)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        print(self.traitCollection.verticalSizeClass == .compact ? "Compact" : "Regular")
        let textView = UITextView()
        textView.text = "Hello, World!"
        print(textView.traitCollection.verticalSizeClass == .compact ? "Compact" : "Regular")
    }
}

