//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Mainul Dip on 6/23/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating view programaticaly
        
        // view is the parent element of all other views that comes with UIViewController
        view.backgroundColor = .blue
        
        let lable = UILabel()
        lable.text = "Second View Controller lable"
        // because textColor: UIColor! { get set }, we can write only .white instade of full UIColor.white
        lable.textColor = .white
        lable.frame = CGRect(x: 0, y: 0, width: 100, height: 67)
        
        // add the newly created lable view inside the container parent view
        view.addSubview(lable)
    }
}
