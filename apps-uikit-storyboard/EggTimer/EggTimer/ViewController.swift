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
    var counting: Int = 0;
    var progress: Float = 0;
    var timer = Timer()
    
    @IBOutlet weak var countDown: UITextField!
    @IBOutlet weak var cookingProgress: UIProgressView!
    
    @IBAction func cookingType(_ sender: UIButton) {
        
        cookingProgress.progress = 0
        progress = 0
        
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
        
        // converting setTimeDuration float into seconds
        let setTimeMinToSec = setTimeDuration!.rounded(.towardZero) / 60
        
        let setTimeSec = setTimeDuration!.truncatingRemainder(dividingBy: 60) * 100
        setTimeDuration = setTimeMinToSec + setTimeSec
        counting = Int(setTimeDuration!)
        
        timer.invalidate() // start fresh
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callBack), userInfo: nil, repeats: true)
    }
    
    @objc func callBack () {
        
        if (counting < 0) {
            countDown.text = "Done Cooking"
            print("Done")
            cookingProgress.progress = 1
            timer.invalidate()
            return
        }
        
        print("\(counting / 3600):\(counting / 60 % 60):\(counting % 60)")
        countDown.text = "\(counting / 3600):\(counting / 60 % 60):\(counting % 60)"
        cookingProgress.progress = progress / setTimeDuration!
        progress += 1
        counting -= 1
    }
    
}


