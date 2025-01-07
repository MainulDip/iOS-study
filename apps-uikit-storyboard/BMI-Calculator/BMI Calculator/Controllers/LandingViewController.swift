//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var bmi : BMI?

    @IBOutlet weak var valueHeight: UILabel!
    @IBOutlet weak var valueWeight: UILabel!
    @IBOutlet weak var sliderHeight: UISlider!
    @IBOutlet weak var sliderWidth: UISlider!
    
    
    var calulatedBMI: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize BMI
        bmi = BMI()
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
        bmi?.setBMI(sliderWidth.value, sliderHeight.value)
        
//        let secondViewController = SecondViewController()
        
//        self.present(secondViewController, animated: true)
        
        // navigation using storyboard, cocoa touch viewController and segue
//        let resultViewController = ResultViewController()
        self.performSegue(withIdentifier: "navigateToResult", sender: self)
        
        // bmi : under weight < 18.5 || Over wight > 24.9
//        let color = UIColor.init(cgColor: )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let resultViewController: ResultViewController = segue.destination as! ResultViewController
        // Pass the selected object to the new view controller.
        resultViewController.bmiObj = self.bmi
    }
    
    // move all the calculation logic to model
    // create a model for BMI
    // create BMI Advice and calculation logic in same model
    
    
}

