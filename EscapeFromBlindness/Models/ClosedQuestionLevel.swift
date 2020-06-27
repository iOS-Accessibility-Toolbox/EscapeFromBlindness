//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class ClosedQuestionLevel: Level {
    typealias Question = String
    var question: Question
    
    init(question: Question, answers: [Answer], validAnswers: [Answer], hints: [String] = []) {
        self.question = question
        super.init(answers: answers, validAnswers: validAnswers, hints: hints)
    }
}
