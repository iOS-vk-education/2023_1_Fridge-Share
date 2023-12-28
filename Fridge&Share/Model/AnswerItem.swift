//
//  AnswerItem.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import Foundation
import FirebaseFirestore

enum answerCase: String {
    case agree = "agree"
    case disagree = "disagree"
    case noanswer = "noanswer"
}

struct AnswerItem {
    
    @DocumentID var id: String?
    let product: Product
    var answer: answerCase
    
    init(id: String? = nil, product: Product, answer: answerCase = .noanswer) {
        self.id = id
        self.product = product
        self.answer = answer
    }
    
    mutating func makeAnswerAgree() {
        answer = .agree
    }
    
    mutating func makeAnswerDisagree() {
        answer = .disagree
    }
}
