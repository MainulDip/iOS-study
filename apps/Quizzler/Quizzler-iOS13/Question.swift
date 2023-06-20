//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Mainul Dip on 6/19/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var answer: String
    
    init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}
