//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class VoiceOverAlertViewControllerTests: XCTestCase {
    
    // MARK: Test Variables
    var sut: VoiceOverAlertViewController!
    var window: UIWindow!
    var coordinator: AppCoordinatorSpy!
    var accessibilityNotificationCenterSpy: AccessibilityNotificationCenterSpy!
    
    // MARK: Test Lifecycle
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Private Methods
    private func setupSUT() {
        window = UIWindow()
        let bundle = Bundle.main
        coordinator = AppCoordinatorSpy()
        accessibilityNotificationCenterSpy = AccessibilityNotificationCenterSpy()
        
        sut = VoiceOverAlertViewController.fromXib(bundle: bundle)
        sut.coordinator = coordinator
        EscapeFromBlindnessAccessibility.shared = accessibilityNotificationCenterSpy
    }
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func unloadView() {
        sut.view.removeFromSuperview()
    }
    
    // MARK: Tests
    func test_voiceOverDisabled_shouldShowVoiceOverActivationInstructions() {
        loadView()
        
        accessibilityNotificationCenterSpy.isVoiceOverRunning = false
        sut.voiceOverStatusChanged()
        
        XCTAssertFalse(sut.voiceOverActivationInstructionsView.isHidden)
        XCTAssertTrue(sut.userCanContinueInstructionsView.isHidden)
    }
    
    func test_voiceOverEnabled_shouldShowUserCanContinueInstructions() {
        loadView()

        accessibilityNotificationCenterSpy.isVoiceOverRunning = true
        sut.voiceOverStatusChanged()

        XCTAssertTrue(sut.voiceOverActivationInstructionsView.isHidden)
        XCTAssertFalse(sut.userCanContinueInstructionsView.isHidden)
    }

    func test_continueButtonTouched_shouldDismissScreen() {
        loadView()
        accessibilityNotificationCenterSpy.isVoiceOverRunning = true
        sut.voiceOverStatusChanged()
        
        sut.continueButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(coordinator.dismissActivateVoiceOverAlertCalled)
    }
    
}
