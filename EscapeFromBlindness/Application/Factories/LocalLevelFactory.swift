//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

// swiftlint:disable line_length
class LocalLevelFactory: LevelFactory {
    static func build() -> [Chapter] {
        return [
            
            Chapter(
                index: 1,
                title: "A new world",
                levels: [
                    ClosedQuestionLevel(
                        question: "What is white's Henry IV horse's color?",
                        answers: ["white", "black", "brown"],
                        validAnswers: ["white"]
                    ),
                    ClosedQuestionLevel(
                        question: "What is black's Henry IV horse's color?",
                        answers: ["white", "black", "brown"],
                        validAnswers: ["black"]
                    ),
                    ClosedQuestionLevel(
                        question: "What is brown's Henry IV horse's color?",
                        answers: ["white", "black", "brown"],
                        validAnswers: ["brown"]
                    ),
                    ClosedQuestionLevel(
                        question: "What is white's Henry IV horse's color?",
                        answers: ["white", "black", "brown"],
                        validAnswers: ["white"]
                    ),
                    ClosedQuestionLevel(
                        question: "What is black's Henry IV horse's color?",
                        answers: ["white", "black", "brown"],
                        validAnswers: ["black"]
                    )
                ]
            ),

            Chapter(
                index: 2,
                levels: [
                    // 5 Rotor Levels
                    RotorLevel(
                        clues: ["It is written 3 on the floor...", "Here I can see a 9 or maybe 5?", "Its written I on the wall", "I just walked on some circular tile..."],
                        answers: ["3051", "6063", "3378"],
                        validAnswers: ["3051"]
                    ),
                    RotorLevel(
                        clues: ["There is nothing interesting in this room..."],
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    RotorLevel(
                        clues: ["There is nothing interesting in this room..."],
                        answers: ["4", "5", "6"],
                        validAnswers: ["4"]
                    ),
                    RotorLevel(
                        clues: ["There is nothing interesting in this room..."],
                        answers: ["7", "8", "9"],
                        validAnswers: ["7"]
                    ),
                    RotorLevel(
                        clues: ["There is nothing interesting in this room..."],
                        answers: ["10", "11", "12"],
                        validAnswers: ["10"]
                    )
                ]
            ),

            Chapter(
                index: 3,
                levels: [
                    // 5 Open Questions
                    OpenQuestionLevel(
                        question: "What is white's Henry IV horse's color?",
                        validAnswers: ["white"]
                    ),
                    OpenQuestionLevel(
                        question: "What is black's Henry IV horse's color?",
                        validAnswers: ["black"]
                    ),
                    OpenQuestionLevel(
                        question: "What is brown's Henry IV horse's color?",
                        validAnswers: ["brown"]
                    ),
                    OpenQuestionLevel(
                        question: "What is white's Henry IV horse's color?",
                        validAnswers: ["white"]
                    ),
                    OpenQuestionLevel(
                        question: "What is black's Henry IV horse's color?",
                        validAnswers: ["black"]
                    )
                ]
            ),
            
            Chapter(
                index: 4,
                levels: [
                    // 5 Search Levels
                    SearchLevel(
                        levelDescription: "There is a level system in front of you...",
                        levelActions: [
                            (description: "There is a lever on your left", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You hear some gear turning noise.", "You fall into a trap...", "You fall into a trap..."]),
                            (description: "There is a lever in the center of the place", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."]),
                            (description: "There is a lever on your right", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."])
                        ],
                        validActions: ["turn it left", "let it in the center", "turn it right"]
                    )!,
                    SearchLevel(
                        levelDescription: "There is a level system in front of you...",
                        levelActions: [
                            (description: "There is a lever on your left", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You hear some gear turning noise.", "You fall into a trap...", "You fall into a trap..."]),
                            (description: "There is a lever in the center of the place", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."]),
                            (description: "There is a lever on your right", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."])
                        ],
                        validActions: ["turn it left", "let it in the center", "turn it right"]
                    )!,
                    SearchLevel(
                        levelDescription: "There is a level system in front of you...",
                        levelActions: [
                            (description: "There is a lever on your left", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You hear some gear turning noise.", "You fall into a trap...", "You fall into a trap..."]),
                            (description: "There is a lever in the center of the place", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."]),
                            (description: "There is a lever on your right", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."])
                        ],
                        validActions: ["turn it left", "let it in the center", "turn it right"]
                    )!,
                    SearchLevel(
                        levelDescription: "There is a level system in front of you...",
                        levelActions: [
                            (description: "There is a lever on your left", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You hear some gear turning noise.", "You fall into a trap...", "You fall into a trap..."]),
                            (description: "There is a lever in the center of the place", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."]),
                            (description: "There is a lever on your right", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."])
                        ],
                        validActions: ["turn it left", "let it in the center", "turn it right"]
                    )!,
                    SearchLevel(
                        levelDescription: "There is a level system in front of you...",
                        levelActions: [
                            (description: "There is a lever on your left", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You hear some gear turning noise.", "You fall into a trap...", "You fall into a trap..."]),
                            (description: "There is a lever in the center of the place", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."]),
                            (description: "There is a lever on your right", actions: ["turn it left", "let it in the center", "turn it right"], results: ["You fall into a trap...", "You hear some gear turning noise.", "You fall into a trap..."])
                        ],
                        validActions: ["turn it left", "let it in the center", "turn it right"]
                    )!
                ]
            )
            
        ]
    }
}
