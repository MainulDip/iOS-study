//
//  CalculateBMI.swift
//  BMI Calculator
//
//  Created by Mainul Dip on 6/25/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

struct CalculateBMI {
    var bmi: Float
    
    mutating func getBMI(_ w: Float, _ h: Float) -> Float {
        bmi = w / powf(h, 2)
        return bmi
    }
    
    // provide ui change based on bmi value
    // move other calculating
}
