//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var qText: UILabel!
    @IBOutlet weak var examProgress: UIProgressView!
    @IBOutlet weak var btnTrue: UIButton!
    @IBOutlet weak var btnFalse: UIButton!
    
    
    var currentQuestion = 0
    var timer = Timer()
    
    
    // Questions Storage
    var questions: [Question] = [  Question(q: "A slug's blood is green.", a: "True"),
                                   Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
                                   Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
                                   Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
                                   Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
                                   Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
                                   Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
                                   Question(q: "Google was originally called 'Backrub'.", a: "True"),
                                   Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
                                   Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
                                   Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
                                   Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    		]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // input question form store
        qText.text = questions[currentQuestion].text
        examProgress.progress = 0
    }

    @IBAction func ansBtnPressed(_ sender: UIButton) {
        
        let questionAns = questions[currentQuestion].answer
        let btn = sender.titleLabel?.text
        
        // Check if anser is correct
        if (btn == questionAns){
            print("Answer is corect")
            sender.backgroundColor = UIColor.green
        } else {
            print("Answer is in-correct")
            sender.backgroundColor = UIColor.red
        }
        
        if (btn == "True"){
            print("True Pressed")
            // Show next
//            nextQuestion()
        } else {
            print("False Pressed")
            // Show next
//            nextQuestion()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
    }
    
    @objc func nextQuestion() {
        currentQuestion += 1
        print(currentQuestion, questions.count, (Float(currentQuestion) / Float(questions.count)))
        if (currentQuestion > (questions.count - 1)) {
            currentQuestion = 0
            print("called2")
        }
        qText.text = questions[currentQuestion].text
        examProgress.progress = Float(currentQuestion) / Float(questions.count)
        btnTrue.backgroundColor = UIColor.clear
        btnFalse.backgroundColor = UIColor.clear
        
        
    }
    
}

