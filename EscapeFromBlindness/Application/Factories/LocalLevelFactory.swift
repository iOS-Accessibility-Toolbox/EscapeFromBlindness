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
            description: """
            After exploring further into the mountain, You reach an old abandonned city which was probably visited by an old Nepalese civilization.
            
            There are several doors locked with a lock safe mechanism in front of you.
            You need to find the code of each of them based on the clues you find in the room.

            When VoiceOver is turned on, you can use the rotor to access the menu. Draw a circle with two fingers on screen as if you were turning a dial. You can then go from one option to the other. Continue to turn your fingers to hear about answer options, until you hear the option. Drag your finger up or down to validate.
            """,
            keywords: ["bear", "wolves", "spikes", "water"],
            levels: [
                // Rotor Levels
                RotorLevel(
                    clues: ["There are bear footprints on the floor", "Wolves are standing close to you", "There are ice spikes on the ceiling above you", "An eagle is on the top of an house of the hidden city"],
                    hints: ["4, 2... Maybe this relates to the number of legs of the animal..."],
                    answers: ["4402", String(randomDigits(4)), String(randomDigits(4))].shuffled(),
                    validAnswers: ["4402"]
                ),
                RotorLevel(
                    clues: ["After progressing into the next room, there is a water stream on your left", "Birds are singing around you, you find it relaxing", "An old owl is standing on the door"],
                    answers: ["BOW", "BAT", "CAT", "ARROW"].shuffled(),
                    validAnswers: ["BOW"]
                )
            ]
        ),

        Chapter(
            index: 3,
            title: "Hidden Valley",
            description: """
            You successfully went through all the traps of the Lost City, now you reach a gigantic valley; there is a waterfall on the left and something that looks like a temple afar.
            You meet an old man that tell congratulates you for going so far into the ice cave.
            He also warns you that, due to some ancient myth, he has to check if you are really the chosen hero, and will have to kill you if you answer wrong to any of its questions!
            """,
            keywords: ["climbing", "waterfall", "temple", "door mechanism"],
            levels: [
                // Open Questions
                OpenQuestionLevel(
                    question: "Hum... What password did you enter in the last room?",
                    validAnswers: ["bow"]
                ),
                OpenQuestionLevel(
                    question: "Hum... The entrance door of the ice cave... did you open it by pulling the lever on the right of the door?",
                    validAnswers: ["no"]
                ),
                OpenQuestionLevel(
                    question: "Well done... Let's see... In which country are we located?",
                    validAnswers: ["nepal"]
                ),
                OpenQuestionLevel(
                    question: "And the last question... Did you fall into some trap during your journey?",
                    validAnswers: ["yes"]
                )
            ]
        ),

        Chapter(
            index: 4,
            title: "The Hidden Tomb",
            description: """
            You successfully went through the Hidden Valley, now you reach a stunning ancient tomb; there is a lot of jewelry on the walls and some some coloured tiles on the floor.

            When VoiceOver is turned on, you can use the rotor to access the Actions menu. Draw a circle with two fingers on screen as if you were turning a dial. You can then go to the Actions option. Continue to turn your fingers to hear about answer options, until you hear the option. Drag your finger up or down to select and double tap to validate.
            """,
            keywords: ["puzzle", "blocks", "walls", "jewels", "tiles"],
            levels: [
                // Search Levels
                SearchLevel(
                    levelDescription: "You approach the first small room with a lot of jewelry on it, it looks like each of them represents an animal...",
                    levelActions: [
                        (description: "A cat is pictured, it looks like a button on the wall, maybe you can press it...", actions: ["activate it", "leave it there"], results: ["You fall into a trap...", "You hear some gear turning noise."]),
                        
                        (description: "An eagle is pictured, it looks like a button on the wall, maybe you can press it...", actions: ["activate it", "leave it there"], results: ["You hear some gear turning noise.", "You fall into a trap..."]),
                        
                        (description: "A snake is pictured, it looks like a button on the wall, maybe you can press it...", ["activate it", "leave it there"], results: ["You fall into a trap...", "You hear some gear turning noise."])
                    ],
                    validActions: ["leave it there", "activate it", "leave it there"]
                )!,
                
                SearchLevel(
                   levelDescription: "You approach the second room with 3 blocks incrusted in the wall... You can probably pull them... A beautiful painting of the mountain is represented on the ceiling...",
                   levelActions: [
                       (description: "The bloc on the left...", actions: ["leave it there", "pull it one time", "pull it two times", "pull it three times"], results: ["You fall into a trap...", "Nothing happens...", "You fall into a trap...", "You fall into a trap...", "You fall into a trap..."]),
                       
                       (description: "The bloc in the middle...", actions: ["leave it there", "pull it one time", "pull it two times", "pull it three times"], results: ["You fall into a trap...", "You fall into a trap...", "Nothing happens...", "You fall into a trap...", "You fall into a trap..."]),
                       
                       (description: "The bloc on the right...", actions: ["leave it there", "pull it one time", "pull it two times", "pull it three times"], results: ["You fall into a trap...", "Nothing happens...", "You fall into a trap...", "You fall into a trap...", "You fall into a trap..."])
                   ],
                   validActions: ["pull it one time", "pull it two times", "pull it one time"]
               )!
            ]
        )
        
    ]
}
