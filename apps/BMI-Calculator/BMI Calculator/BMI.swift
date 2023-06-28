//
//  BMI.swift
//  BMI Calculator
//
//  Created by Mainul Dip on 6/25/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct BMI {
    var bmi: Float
    
    let bmiThresholds: [BMIId: Float] = [BMIId.bad: 0, BMIId.bad: 0, BMIId.ugly: 0]
    let bmiSuggessions: [BMIId: String] = [BMIId.good: "Do Some Work", BMIId.bad: "Do some", BMIId.ugly: "Do something"]
    let bmiColors: [BMIId: UIColor] = [BMIId.good: .green, BMIId.bad: .yellow, BMIId.ugly: .red]
    
    mutating func getBMI(_ w: Float, _ h: Float) -> Float {
        bmi = w / powf(h, 2)
        return bmi
    }
    
    // a function to response on returning tuple (bmiThresholds, bmiSuggessions, bmiColors to change the UI background)
}

enum BMIId {
    case good, bad, ugly;
}
