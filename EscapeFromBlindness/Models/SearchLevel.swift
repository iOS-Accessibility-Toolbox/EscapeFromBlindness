//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

/// explore an area using Custom Actions, you have to perform the actions in a specific order then open the exit door.
/// after performing each action, one of these three outcomes occurs:  death, idle, progress.
/// Example: ROOM: "You see a door, what do you do?" => ["Listen", "You hear a strange voice...", nil], ["Knock" => ...
/// Only one path is correct.
class SearchLevel: Level {
    
    let levelDescription: String
    let levelActions: [(description: String, actions: [String], results: [String])]
    
    init?(
        levelDescription: String,
        levelActions: [(description: String, actions: [String], results: [String])],
        validActions: [String]
    ) {
        let actions = levelActions.map { $0.actions }
        let results = levelActions.map { $0.results }
        
        guard actions.count == results.count else {
            return nil
        }
        guard actions.count == validActions.count else {
            return nil
        }
        
        self.levelDescription = levelDescription
        self.levelActions = levelActions
        
        super.init(answers: [], validAnswers: validActions)
    }
}
