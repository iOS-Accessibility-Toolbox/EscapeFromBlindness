//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class OpenQuestionLevel: Level {
    typealias Question = String
    var question: Question
    
    init(question: Question, validAnswers: [Answer]) {
        self.question = question
        super.init(answers: [], validAnswers: validAnswers)
    }
}
//extension OpenQuestionLevel: Equatable {}
