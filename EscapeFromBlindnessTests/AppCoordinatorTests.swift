//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit
import XCTest
@testable import EscapeFromBlindness

class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    var gameFlowMock: GameFlowMock!
    var userDefaultsMock: UserDefaults!
    var accessibilityNotificationCenterSpy: AccessibilityNotificationCenterSpy!
    
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    private func setupSUT() {
        gameFlowMock = GameFlowMock()
        userDefaultsMock = UserDefaultsMock()
        accessibilityNotificationCenterSpy = AccessibilityNotificationCenterSpy()
        
        sut = AppCoordinator(userDefaults: userDefaultsMock, gameFlow: gameFlowMock)//GameFlow(chapters: [], currentChapterIndex: 1, currentLevelIndex: 0))
        EscapeFromBlindnessAccessibility.shared = accessibilityNotificationCenterSpy
    }
    
    // MARK: Test Doubles
    class GameFlowMock: GameFlowProtocol {
        var expectedChapter: Int = 0
        var expectedLevel: Int = 0
        
        func getCurrentChapterIndex() -> Int {
            return self.expectedChapter
        }
        func getCurrentLevelIndex() -> Int {
            return self.expectedLevel
        }
        func start() {}
        func validate(_ answer: Level.Answer) {}
        func validateChapter() {}
    }
    
    // MARK: Loading
    func test_IntroScreenNotCompleted_Start_shouldPresentIntroScreen() {
        userDefaultsMock.set(0, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)
        
        sut.start(window: UIWindow())
        
        XCTAssertTrue(sut.isPresentIntroControllerCalled)
    }
    
    func test_IntroScreenCompleted_Start_NoLevelsCompleted_shouldPresentChapterScreenWithCurrentProgress() {
        userDefaultsMock.set(1, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)

        sut.start(window: UIWindow())

        XCTAssertTrue(sut.isPresentChapterControllerCalled)
    }

    func test_IntroScreenCompleted_Start_OneLevelCompleted_shouldPresentChapterScreenWithCurrentProgress() {
        userDefaultsMock.set(2, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)

        sut.start(window: UIWindow())

        XCTAssertTrue(sut.isPresentChapterControllerCalled)
    }
    
    // MARK: Saving
    func test_routingToChapterTriggered_shouldSaveChapterIndexToPreferences_IfNewChapter() {
        sut.start(window: UIWindow())
        
        let chapterIndex = 2
        sut.routeToChapter(Chapter(index: chapterIndex, levels: []), isNewChapter: true)
        
        let foundChapter = userDefaultsMock.value(forKey: UserDefaultsKeys.currentChapterIndex.rawValue) as! Int
        let foundLevel = userDefaultsMock.value(forKey: UserDefaultsKeys.currentLevelIndex.rawValue) as! Int
        XCTAssertEqual(foundChapter, chapterIndex)
        XCTAssertEqual(foundLevel, 0)
    }
    
    func test_routingToLevelTriggered_shouldSaveLevelIndexToPreferences() {
        sut.start(window: UIWindow())
        
        gameFlowMock.expectedLevel = 4
        sut.routeToLevel(Level(answers: [], validAnswers: []))
        
        let foundLevel = userDefaultsMock.value(forKey: UserDefaultsKeys.currentLevelIndex.rawValue) as! Int
        XCTAssertEqual(foundLevel, 4)
    }
    
    // MARK: Voice Over Activation Tests
    func test_IntroVCIsPresented_VoiceOverDisabled_shouldNotPresentVoiceOverAlert() {
        sut.presentIntroController()
        
        accessibilityNotificationCenterSpy.isVoiceOverRunning = false
        sut.voiceOverStatusChanged()
        
        XCTAssertFalse(sut.isVoiceOverAlertActive)
    }
    
    func test_SomeVCIsPresented_VoiceOverDisabled_shouldPresentVoiceOverAlert() {
        sut.presentChapterController(Chapter(index: 0, levels: []))
        
        accessibilityNotificationCenterSpy.isVoiceOverRunning = false
        sut.voiceOverStatusChanged()

        XCTAssertTrue(sut.isVoiceOverAlertActive)
    }

    func test_IntroVCIsPresented_VoiceOverEnabled_shouldNotPresentVoiceOverAlert() {
       sut.presentIntroController()
        
        accessibilityNotificationCenterSpy.isVoiceOverRunning = true
        sut.voiceOverStatusChanged()

        XCTAssertFalse(sut.isVoiceOverAlertActive)
    }
    
    func test_SomeVCIsPresented_VoiceOverEnabled_shouldNotPresentVoiceOverAlert() {
        sut.presentChapterController(Chapter(index: 0, levels: []))
    
        accessibilityNotificationCenterSpy.isVoiceOverRunning = true
        sut.voiceOverStatusChanged()

        XCTAssertFalse(sut.isVoiceOverAlertActive)
    }
    
    // MARK: Title Display Test
    func test_ClosedQuestionLevelVCIsPresented_navigationBarShouldDisplayCurrentLevel() {
        let level = ClosedQuestionLevel(question: "", answers: [], validAnswers: [])
        
        sut.presentClosedQuestionController(level)
        
        assertNavBarLevel(1)
    }
    
    func test_OpenQuestionLevelVCIsPresented_navigationBarShouldDisplayCurrentLevel() {
        let level = OpenQuestionLevel(answers: [], validAnswers: [])
        
        sut.presentOpenQuestionController(level)
        
        assertNavBarLevel(1)
    }
    
    func test_RotorQuestionVCIsPresented_navigationBarShouldDisplayCurrentLevel() {
        let level = RotorLevel(clues: [], answers: [], validAnswers: [])
        
        sut.presentRotorQuestionController(level)
        
        assertNavBarLevel(1)
    }
    
    func test_SearchQuestionVCIsPresented_navigationBarShouldDisplayCurrentLevel() {
        let level = SearchLevel(answers: [], validAnswers: [])
        
        sut.presentSearchQuestionController(level)
        
        assertNavBarLevel(1)
    }
    
    func test_MazeQuestionVCIsPresented_navigationBarShouldDisplayCurrentLevel() {
        let level = MazeLevel(answers: [], validAnswers: [])
        
        sut.presentMazeQuestionController(level)
        
        assertNavBarLevel(1)
    }
    
    private func assertNavBarLevel(_ level: Int) {
        XCTAssertEqual(sut.navigationController.viewControllers.first!.navigationItem.title, "Level \(level)")
    }
    
}
