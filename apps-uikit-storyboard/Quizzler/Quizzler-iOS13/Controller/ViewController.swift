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
    @IBOutlet weak var scoreField: UITextField!
        
    private var questionStore = QuestionStore()
    
    // computed properties
    var questions: [Question] {
        get { questionStore.questions }
    }
    
    
    // computed properties
    var currentQuestion: Int {
        get { questionStore.currentQuestion }
        set { questionStore.currentQuestion = newValue }
    }
    var timer = Timer()
    
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
        
        
        // check if answer is correct and get the boolean result
        let isAnswerCorrect: Bool = questionStore.checkAnswer(btn!)
        
        
        
        // Check if anser is correct
        if isAnswerCorrect {
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
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        
        // point next question and update ui
        let nextQuestion: Int = questionStore.getNextQuestion()
        print(nextQuestion)
        
        qText.text = questions[currentQuestion].text
        
        // Update Progress
        examProgress.progress = Float(currentQuestion) / Float(questions.count - 1)
        
        // Update UI to reflect right or wrong answer
        btnTrue.backgroundColor = UIColor.clear
        btnFalse.backgroundColor = UIColor.clear
        
        // Update Score
        scoreField.text = String(questionStore.score)
        
    }
    
}

