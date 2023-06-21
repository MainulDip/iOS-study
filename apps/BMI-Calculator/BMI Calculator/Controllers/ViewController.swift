//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var valueHeight: UILabel!
    @IBOutlet weak var valueWeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func sliderHeightChange(_ sender: UISlider) {
        print(sender.value)
        valueHeight.text = "\(String(format: "%.1f",Float(sender.value)))m"
        print(valueHeight.text ?? "Height Value")
    }
    
    @IBAction func sliderWeightChange(_ sender: UISlider) {
        print(sender.value)
//        valueWeight.text = String(Int(sender.value))
    }
}

