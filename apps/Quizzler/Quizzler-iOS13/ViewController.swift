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
    
    
    // Questions Storage
    var questions: [Question] = [Question(text: "1 + 2 = 3", answer: "True"),
                                 Question(text: "2 + 2 = 2", answer: "False"),
                                 Question(text: "3 + 4 = 7", answer: "True")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // input question form store
        qText.text = questions[currentQuestion].text
    }

    @IBAction func ansBtnPressed(_ sender: UIButton) {
        
        let questionAns = questions[currentQuestion].answer
        let btn = sender.titleLabel?.text
        
        // Check if anser is correct
        if (btn == questionAns){
            print("Answer is corect")
        } else {
            print("Answer is in-correct")
        }
        
        if (btn == "True"){
            print("True Pressed")
            // Show next
            nextQuestion()
        } else {
            print("False Pressed")
            // Show next
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        currentQuestion += 1
        print(currentQuestion, questions.count)
        if (currentQuestion > (questions.count - 1)) {
            currentQuestion = 0
            print("called2")
        }
        qText.text = questions[currentQuestion].text
        
        
    }
    
}

