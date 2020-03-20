//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

// swiftlint:disable line_length
class LocalLevelFactory: LevelFactory {
    
    static func build() -> [Chapter] {
        return LocalLevelFactory.chapters
    }
    
    static let chapters = [
        Chapter(
            index: 1,
            title: "Ice Cave",
            description: L10n.chapter1Description,
            keywords: ["door", "trap", "bridge", "bats", "lever"],
            levels: [
                // Closed Questions
                ClosedQuestionLevel(question: L10n.cq1, answers: [L10n.cq1a1, L10n.cq1a2, L10n.cq1a3].shuffled(), validAnswers: [L10n.cq1a1]),
                
                ClosedQuestionLevel(question: L10n.cq2, answers: [L10n.cq2a1, L10n.cq2a2, L10n.cq2a3].shuffled(), validAnswers: [L10n.cq2a3]),
                
                ClosedQuestionLevel(question: L10n.cq3, answers: [L10n.cq3a1, L10n.cq3a2, L10n.cq3a3].shuffled(), validAnswers: [L10n.cq3a1]),
                
                ClosedQuestionLevel(question: L10n.cq4, answers: [L10n.cq4a1, L10n.cq4a2, L10n.cq4a3].shuffled(), validAnswers: [L10n.cq4a2])
            ]
        ),

        Chapter(
            index: 2,
            title: "The Lost City",
            description: L10n.chapter2Description,
            keywords: ["bear", "wolves", "spikes", "water"],
            levels: [
                // Rotor Levels
                RotorLevel(
                    clues: [L10n.chapter2Cq1a1, L10n.chapter2Cq1a2, L10n.chapter2Cq1a3, L10n.chapter2Cq1a4],
                    hints: [L10n.chapter2Cq1h1],
                    answers: ["4402", String(randomDigits(4)), String(randomDigits(4))].shuffled(),
                    validAnswers: ["4402"]
                ),
                RotorLevel(
                    clues: [L10n.chapter2Cq2a1, L10n.chapter2Cq2a2, L10n.chapter2Cq2a3],
                    answers: [L10n.chapter2Cq2aa1, L10n.chapter2Cq2aa2, L10n.chapter2Cq2aa3, L10n.chapter2Cq2aa4].shuffled(),
                    validAnswers: [L10n.chapter2Cq2aa1]
                )
            ]
        ),

        Chapter(
            index: 3,
            title: "Hidden Valley",
            description: L10n.chapter3Description,
            keywords: ["climbing", "waterfall", "temple", "door mechanism"],
            levels: [
                // Open Questions
                OpenQuestionLevel(
                    question: L10n.chapter3Q1,
                    validAnswers: [L10n.chapter3A1]
                ),
                OpenQuestionLevel(
                    question: L10n.chapter3Q2,
                    validAnswers: [L10n.chapter3A2]
                ),
                OpenQuestionLevel(
                    question: L10n.chapter3Q3,
                    validAnswers: [L10n.chapter3A3]
                ),
                OpenQuestionLevel(
                    question: L10n.chapter3Q4,
                    validAnswers: [L10n.chapter3A4]
                )
            ]
        ),

        Chapter(
            index: 4,
            title: "The Hidden Tomb",
            description: L10n.chapter4Description,
            keywords: ["puzzle", "blocks", "walls", "jewels", "tiles"],
            levels: [
                // Search Levels
                SearchLevel(
                    levelDescription: L10n.chapter4L1desc,
                    levelActions: [
                        (description: L10n.chapter4Cq1desc, actions: [L10n.chapter4Cq1a1, L10n.chapter4Cq1a2], results: [L10n.chapter4Cq1r1, L10n.chapter4Cq1r2]),
                        
                        (description: L10n.chapter4Cq2desc, actions: [L10n.chapter4Cq1a1, L10n.chapter4Cq1a2], results: [L10n.chapter4Cq1r2, L10n.chapter4Cq1r1]),
                        
                        (description: L10n.chapter4Cq3desc, [L10n.chapter4Cq1a1, L10n.chapter4Cq1a2], results: [L10n.chapter4Cq1r1, L10n.chapter4Cq1r2])
                    ],
                    validActions: [L10n.chapter4Cq1a2, L10n.chapter4Cq1a1, L10n.chapter4Cq1a2]
                )!,
                
                SearchLevel(
                   levelDescription: L10n.chapter4L2desc,
                   levelActions: [
                    (description: L10n.chapter4Cq2desc1, actions: [L10n.chapter4Cq2a1, L10n.chapter4Cq2a2, L10n.chapter4Cq2a3, L10n.chapter4Cq2a4], results: [L10n.chapter4Cq2r1, L10n.chapter4Cq2r2, L10n.chapter4Cq2r1, L10n.chapter4Cq2r1, L10n.chapter4Cq2r1]),
                       
                       (description: L10n.chapter4Cq2desc2, actions: [L10n.chapter4Cq2a1, L10n.chapter4Cq2a2, L10n.chapter4Cq2a3, L10n.chapter4Cq2a4], results: [L10n.chapter4Cq2r1, L10n.chapter4Cq2r1, L10n.chapter4Cq2r2, L10n.chapter4Cq2r1]),
                       
                       (description: L10n.chapter4Cq2desc3, actions: [L10n.chapter4Cq2a1, L10n.chapter4Cq2a2, L10n.chapter4Cq2a3, L10n.chapter4Cq2a4], results: [L10n.chapter4Cq2r1, L10n.chapter4Cq2r2, L10n.chapter4Cq2r1, L10n.chapter4Cq2r1])
                   ],
                   validActions: [L10n.chapter4Cq2a2, L10n.chapter4Cq2a3, L10n.chapter4Cq2a2]
               )!
            ]
        )
        
    ]
}
