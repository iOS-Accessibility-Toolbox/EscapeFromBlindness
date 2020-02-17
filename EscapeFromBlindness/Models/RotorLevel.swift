//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class RotorLevel: Level {
    typealias Clue = String
    var clues: [Clue]
    
    init(clues: [Clue], answers: [Answer], validAnswers: [Answer]) {
        self.clues = clues
        super.init(answers: answers, validAnswers: validAnswers)
    }
}
//extension RotorLevel: Equatable {}
