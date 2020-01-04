//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit
import XCTest
@testable import EscapeFromBlindness

class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    var userDefaultsMock: UserDefaults!
    var accessibilityNotificationCenterSpy: AccessibilityNotificationCenterSpy!
    
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    private func setupSUT() {
        userDefaultsMock = UserDefaultsMock()
        accessibilityNotificationCenterSpy = AccessibilityNotificationCenterSpy()
        
        sut = AppCoordinator(userDefaults: userDefaultsMock)
        EscapeFromBlindnessAccessibility.shared = accessibilityNotificationCenterSpy
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
        userDefaultsMock.set(3, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)

        sut.start(window: UIWindow())

        XCTAssertTrue(sut.isPresentChapterControllerCalled)
    }
    
    // MARK: Voice Over Activation Tests
    func test_IntroVCIsPresented_VoiceOverDisabled_shouldNotPresentVoiceOverAlert() {
        sut.presentIntroController()
        
        accessibilityNotificationCenterSpy.isVoiceOverRunning = false
        sut.voiceOverStatusChanged()
        
        XCTAssertFalse(sut.isVoiceOverAlertActive)
    }
    
    func test_SomeVCIsPresented_VoiceOverDisabled_shouldPresentVoiceOverAlert() {
        sut.presentGameController()
        
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
        sut.presentGameController()
    
        accessibilityNotificationCenterSpy.isVoiceOverRunning = true
        sut.voiceOverStatusChanged()

        XCTAssertFalse(sut.isVoiceOverAlertActive)
    }
    
}
