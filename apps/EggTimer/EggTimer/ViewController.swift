//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func cookingType(_ sender: UIButton) {
        let buttonName = sender.titleLabel!.text
        switch buttonName {
        case "Soft" :
            print("Soft Egg")
        case "Medium":
            print("Medium Egg")
        case "Hard":
            print("Hard Egg")
        default:
            print("Default Case")
        }
    }
    
}
