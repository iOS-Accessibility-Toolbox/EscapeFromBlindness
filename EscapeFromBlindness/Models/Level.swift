//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class Level {
    typealias Answer = String
    public let answers: [Answer]
    public let validAnswers: [Answer]
    
    init(answers: [Answer], validAnswers: [Answer]) {
        self.answers = answers
        self.validAnswers = validAnswers
    }
}
