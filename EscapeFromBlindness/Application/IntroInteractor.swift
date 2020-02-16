//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

protocol IntroInteractorProtocol {
    func fetchInstructions() -> [String]
}

class IntroInteractor: IntroInteractorProtocol {
    
    func fetchInstructions() -> [String] {
        return [
            "Welcome to Escape From Blindness!",
            "You are an explorer of an old tomb!",
            "Your torch just turned off!",
            "This game is 100% based on VoiceOver usage!",
            "VoiceOver is an assistive technology that allows blind users to use their smartphones.",
            "In this adventure, you will have to activate VoiceOver to progress!",
            "You will be faced dozens of unique levels to will use the assistive technology's features!",
            "Good luck adventurer!"
        ]
    }
    
}
