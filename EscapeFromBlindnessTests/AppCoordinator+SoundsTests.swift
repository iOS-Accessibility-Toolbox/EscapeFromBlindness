//
//  Created by Michael Martinez on 19/03/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class AppCoordinatorSoundsTests: XCTestCase {
    
    var sut: AppCoordinator!
    var gameFlowMock: GameFlowMock!
    var userDefaultsMock: UserDefaults!
    var soundPlayerSpy: SoundPlayerSpy!
    
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    private func setupSUT() {
        gameFlowMock = GameFlowMock()
        userDefaultsMock = UserDefaultsMock()
        soundPlayerSpy = SoundPlayerSpy()
        
        sut = AppCoordinator(userDefaults: userDefaultsMock, gameFlow: gameFlowMock, soundPlayer: soundPlayerSpy)
    }
    
    // MARK: Test Doubles
    class SoundPlayerSpy: SoundPlayerProtocol {
        var startedSoundType: CustomSoundTypes?
        var stopCalled = false
        
        func start(type: CustomSoundTypes) {
            startedSoundType = type
        }
        
        func stop() {
            stopCalled = true
        }
    }
    
    // MARK: Tests
    func test_whenNewChapterBegins_shouldStartNewChaptersMusic() {
        sut.start(window: UIWindow())
        
        let chapterIndex = 2
        sut.routeToChapter(Chapter(index: chapterIndex, levels: []), isNewChapter: true)
        
        XCTAssertTrue(soundPlayerSpy.stopCalled)
        XCTAssertEqual(soundPlayerSpy.startedSoundType, CustomSoundTypes.allCases[chapterIndex - 1])
    }
    
}
