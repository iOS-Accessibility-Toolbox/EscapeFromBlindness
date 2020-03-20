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
            L10n._1,
            L10n._2,
            L10n._3,
            L10n._4,
            L10n._5,
            L10n._6,
            L10n._7,
            L10n._8
        ]
    }
    
    func fetchGameEndInstructions() -> [String] {
        return [
            L10n.a,
            L10n.b,
            L10n.c,
            L10n.d,
            L10n.e + "\(supportUrl)",
            L10n.f
        ]
    }
    
}
