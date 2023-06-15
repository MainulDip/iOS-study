//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let hardNess: [String: Float] = ["Soft":0.1,"Medium":0.2,"Hard": 0.3]
    
    var setTimeDuration: Float?
    var counter: Float = 0;
    var timer = Timer()
    
    @IBAction func cookingType(_ sender: UIButton) {
        let buttonName = sender.titleLabel!.text
        
        
        
        
        switch buttonName {
        case "Soft" :
//            print("Soft Egg : \(hardNess["Soft"]!)")
            setTimeDuration = hardNess["Soft"]!
        case "Medium":
//            print("Medium Egg : \(hardNess["Medium"]!)")
            setTimeDuration = hardNess["Medium"]!
        case "Hard":
//            print("Hard Egg : \(hardNess["Hard"]!)")
            setTimeDuration = hardNess["Hard"]!
        default:
//            print("Default Case")
            setTimeDuration = 0
        }
        	
//        func sayhi() {
            timer.invalidate() // just in case this button is tapped multiple times

                    // start the timer
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callBack), userInfo: nil, repeats: true)
//        }
        
        
//        print(setTimeDuration!, sayhi())
//        sayhi()
    }
    
    @objc func callBack () {
        
        print(Int(counter))
        
        if (counter >= setTimeDuration! * 60) {
            timer.invalidate()
            print("Done")
        }
        
        // Task
        // Convert decima into secnds
        // count reverse order on the setTimeDuration -= 1 and stop at 0
        
        counter += 1
    }
    
}


