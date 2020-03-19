//
//  Created by Michael Martinez on 19/03/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
@testable import EscapeFromBlindness

class GameFlowMock: GameFlowProtocol {
    var expectedChapter: Int = 0
    var expectedChapterTitle: String = ""
    var expectedLevel: Int = 0
    var startCalled = false
    
    func getCurrentChapterIndex() -> Int {
        return self.expectedChapter
    }
    func getCurrentChapterTitle() -> String? {
        return self.expectedChapterTitle
    }
    func getCurrentLevelIndex() -> Int {
        return self.expectedLevel
    }
    func start() {
        startCalled = true
    }
    func restart() {}
    func validate(_ answers: [Level.Answer]) {}
    func validateChapter() {}
}
