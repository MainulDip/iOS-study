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
    @IBOutlet weak var sliderHeight: UISlider!
    @IBOutlet weak var sliderWidth: UISlider!
    
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
        valueWeight.text = "\(String(format: "%.0f",Float(sender.value)))Kg"
    }
    @IBAction func calculateBtn(_ sender: UIButton) {
        // calcuate the BMI value and send it to the SecondViewController to display
        let bmi = sliderWidth.value / pow(sliderHeight.value, 2)
        
        let secondViewController = SecondViewController()
        
        self.present(secondViewController, animated: true)
        
        // bmi : under weight < 18.5 || Over wight > 24.9
        let color = UIColor.init(cgColor: )
    }
}

