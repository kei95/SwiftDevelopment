//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Yamashtia Keisuke on 2019-08-31.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponceType
    var answers: [Answer]
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum ResponceType {
    case single, multiple, ranged
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var defenition: String {
        switch self {
        case .dog:
            return "You are incredibly out going. you surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyound your years, and you focus on the details. slow and steady wins the race."
        }
    }
}
