//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    let images: [String] = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"];
    var leftDiceNumber: Int?
    var rightDiceNumber: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        diceImageView1.image = #imageLiteral(resourceName: "DiceSix")
        diceImageView1.alpha = 0.4
        
        diceImageView2.image = #imageLiteral(resourceName: "DiceTwo")
        diceImageView2.alpha = 0.4
    }
    
    @IBAction func rollButtonPressed(_ sender: Any) {
        
        leftDiceNumber = Int.random(in: 0..<images.count)
        rightDiceNumber = Int.random(in: 0..<self.images.count)
        
        print("Button got tapped!!!!");
        print("Dices images count: \(images.count)")
        
        
        diceImageView1.image =  UIImage(imageLiteralResourceName: images[leftDiceNumber!])
        
        diceImageView2.image =  UIImage(imageLiteralResourceName: images.randomElement()!) // array.randomElement() is used instade of reandom number generator
        
        
//        leftDiceNumber += 1;
//        rightDiceNumber += 1;
        
    }
}
