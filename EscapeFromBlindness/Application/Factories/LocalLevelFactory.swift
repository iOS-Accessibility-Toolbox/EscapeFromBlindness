//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

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
                        answers: ["3051", "6063", "3378"],
                        validAnswers: ["3051"]
                    ),
                    RotorLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    RotorLevel(
                        answers: ["4", "5", "6"],
                        validAnswers: ["4"]
                    ),
                    RotorLevel(
                        answers: ["7", "8", "9"],
                        validAnswers: ["7"]
                    ),
                    RotorLevel(
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
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    OpenQuestionLevel(
                        answers: ["4", "5", "6"],
                        validAnswers: ["4"]
                    ),
                    OpenQuestionLevel(
                        answers: ["7", "8", "9"],
                        validAnswers: ["7"]
                    ),
                    OpenQuestionLevel(
                        answers: ["10", "11", "12"],
                        validAnswers: ["10"]
                    ),
                    OpenQuestionLevel(
                        answers: ["10", "11", "12"],
                        validAnswers: ["10"]
                    )
                ]
            ),
            
            Chapter(
                index: 4,
                levels: [
                    // 5 Search Levels
                    SearchLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    SearchLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    SearchLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    SearchLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    SearchLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    )
                ]
            ),
            
            Chapter(
                index: 5,
                levels: [
                    // 5 Maze Levels
                    MazeLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    MazeLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    MazeLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    MazeLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    ),
                    MazeLevel(
                        answers: ["1", "2", "3"],
                        validAnswers: ["1"]
                    )
                ]
            )
            
        ]
    }
}
