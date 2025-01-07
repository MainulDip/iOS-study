//
//  BMI.swift
//  BMI Calculator
//
//  Created by Mainul Dip on 6/25/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct BMI {
    var bmi: Float?
    
    let bmiThresholds: [BMIId: Float] = [BMIId.good: 0, BMIId.bad: 0, BMIId.ugly: 0]
    let bmiSuggessions: [BMIId: String] = [BMIId.good: "Do Some Work", BMIId.bad: "Do some", BMIId.ugly: "Do something"]
    let bmiColors: [BMIId: UIColor] = [BMIId.good: .green, BMIId.bad: .yellow, BMIId.ugly: .red]
    
    mutating func setBMI(_ w: Float, _ h: Float) {
        bmi = w / powf(h, 2)
    }
    
    // a function to response on returning tuple (bmiThresholds, bmiSuggessions, bmiColors to change the UI background)
    // call this function on the second screen and get the tuple value by spreading into variable and apply form the controller, when unmounted, this struct needs to be set nil
    func bmiSideEffect() -> (String, UIColor) {
        
        var bmiSelectedIdentifier: BMIId
        if(bmi! <= bmiThresholds[BMIId.good]!) {
            bmiSelectedIdentifier = BMIId.good
        } else if (bmi! >= bmiThresholds[BMIId.bad]!) {
            bmiSelectedIdentifier = BMIId.bad
        } else {
            bmiSelectedIdentifier = BMIId.ugly
        }

        return (bmiSuggessions[bmiSelectedIdentifier]!, bmiColors[bmiSelectedIdentifier]!)
    }
}

enum BMIId {
    case good, bad, ugly;
}
