//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Mainul Dip on 6/24/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultBackground: UIImageView!
    @IBOutlet weak var bmiScore: UILabel!
    @IBOutlet weak var resultAdvice: UILabel!
    var bmiObj: BMI?
    
    // add all the ui IBOutlets to change UI Background color form the bmi response
    // also show the suggessions based on the responses

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(bmiObj?.bmi ?? "bmi not set yet", "From ResultViewController")

        let (advice, color) = bmiObj!.bmiSideEffect()
        resultBackground.backgroundColor = color
        resultAdvice.text = advice
        resultAdvice.textColor = .black
        print(advice, "Advice")
    }
    
    @IBAction func reCalculate(_ sender: UIButton) {
        bmiObj = nil
//        navigationController?.popToViewController(LandingViewController() as UIViewController, animated: true)
        self.dismiss(animated: true, completion: nil)
        print(bmiObj?.bmi ?? "bmi cleared")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
