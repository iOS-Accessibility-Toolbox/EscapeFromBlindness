//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class RotorLevel: Level {
    typealias Clue = String
    var clues: [Clue]
    var hints: [String]
    
    init(clues: [Clue], hints: [String] = [], answers: [Answer], validAnswers: [Answer]) {
        self.clues = clues
        self.hints = hints
        super.init(answers: answers, validAnswers: validAnswers)
    }
}
