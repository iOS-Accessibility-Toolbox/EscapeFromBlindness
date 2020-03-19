//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

protocol InstructionsInteractorProtocol {
    func fetchIntroInstructions() -> [String]
    func fetchGameEndInstructions() -> [String]
}

class InstructionsInteractor: InstructionsInteractorProtocol {
    
    private let supportUrl = "https://one-week-apps.com"
    
    func fetchIntroInstructions() -> [String] {
        return [
            "Welcome to Escape From Blindness!",
            "You are an explorer of an old tomb!",
            "Your torch just turned off!",
            "This game is 100% based on VoiceOver usage!",
            "VoiceOver is an assistive technology that allows blind users to use their smartphones.",
            "In this adventure, you will have to activate VoiceOver to progress!",
            "You will be faced tens of unique levels to will use the assistive technology's features!",
            "Good luck explorer!"
        ]
    }
    
    func fetchGameEndInstructions() -> [String] {
        return [
            "Congratulations!",
            "You successfully managed to go through all game levels!",
            "We hope you enjoyed this game as much as we enjoyed developing it!",
            "We also hope that this game helped you to understand better some of the challenges encoutered by blind people while using smartphones :)",
            "If you enjoyed the game and feel like you would like to build your own levels, feel free to submit your ideas in the contact section of our website: \(supportUrl)",
            "This can be a completely new story based on the game modes you just played :)"
        ]
    }
    
}
