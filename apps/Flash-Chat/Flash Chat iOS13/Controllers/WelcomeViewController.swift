//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = K.appName
//        
//        var count = 0.0
//        let textToAnimate = "⚡️FlashChat"
//        
//        for letter in textToAnimate {
//            
//            Timer.scheduledTimer(withTimeInterval: 0.1 * count, repeats: false) {_ in
//                self.titleLabel.text?.append(letter)
//            }
//            
//            count += 1
//            
//            
//        }
       
    }
    

}
