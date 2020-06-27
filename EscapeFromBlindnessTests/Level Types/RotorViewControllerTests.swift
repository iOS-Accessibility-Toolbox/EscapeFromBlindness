//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class RotorViewControllerTests: XCTestCase {
    
    // MARK: - Test Variables
    var sut: RotorViewController!
    var window: UIWindow!
    var coordinator: AppCoordinatorSpy!
    var accessibilitySpy: AccessibilityNotificationCenterSpy!
    
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
        coordinator = AppCoordinatorSpy()
        accessibilitySpy = AccessibilityNotificationCenterSpy()
        EscapeFromBlindnessAccessibility.shared = accessibilitySpy
    }
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func unloadView() {
        sut.view.removeFromSuperview()
    }
    
    // MARK: Tests
    func test_whenViewLoads_shouldDisplayClues() {
        sut = RotorViewController(level: RotorLevel(clues: ["C1", "C2", "C3"], answers: [], validAnswers: []))
        
        loadView()
        
        XCTAssertEqual(sut.clueViews[0].accessibilityLabel, "C1")
        XCTAssertEqual(sut.clueViews[1].accessibilityLabel, "C2")
        XCTAssertEqual(sut.clueViews[2].accessibilityLabel, "C3")
    }
    
    func test_whenViewLoads_shouldDisplayLockedDoorLabelWithRotorOptions_WithCorrectAnswers() {
        sut = RotorViewController(level: RotorLevel(clues: [], answers: ["A1", "A2"], validAnswers: []))
        
        loadView()
        
        XCTAssertNotNil(sut.lockedDoorView)
        XCTAssertEqual(sut.lockedDoorView.accessibilityCustomRotors![0].name, "A1")
        XCTAssertEqual(sut.lockedDoorView.accessibilityCustomRotors![1].name, "A2")
    }
    
    func test_whenViewLoads_withNoHints_shouldIndicateNoHints() {
        sut = RotorViewController(level: RotorLevel(clues: [], answers: ["A1", "A2"], validAnswers: [], hints: []))
        
        loadView()
        sut.onHintsButtonTouched()
        
        XCTAssertEqual(accessibilitySpy.notification, .announcement)
        let spokenMessage = accessibilitySpy.argument as? String
        XCTAssertTrue(spokenMessage?.contains("Aucun indice") ?? false)
    }
    
    func test_whenViewLoads_shouldIndicateNoHintsYet() {
        sut = RotorViewController(level: RotorLevel(clues: [], answers: ["A1", "A2"], validAnswers: [], hints: ["H1", "H2", "H3"]))
        
        loadView()
        sut.onHintsButtonTouched()
        
        XCTAssertEqual(accessibilitySpy.notification, .announcement)
        let spokenMessage = accessibilitySpy.argument as? String
        XCTAssertTrue(spokenMessage?.contains("Patiente quelques instants pour obtenir des indices supplémentaires") ?? false)
    }
    
    func test_whenViewLoads_afterHintUnlockDelay_shouldSpeakFirstHint() {
        sut = RotorViewController(level: RotorLevel(clues: [], answers: ["A1", "A2"], validAnswers: [], hints: ["H1", "H2", "H3"]))
        sut.kHintUnlockTimeInterval = 0.1
        loadView()
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
        
        sut.onHintsButtonTouched()

        XCTAssertEqual(accessibilitySpy.notification, .announcement)
        let spokenMessage = accessibilitySpy.argument as? String
        XCTAssertTrue(spokenMessage?.contains("H1") ?? false)
        XCTAssertFalse(spokenMessage?.contains("H2") ?? true)
        XCTAssertFalse(spokenMessage?.contains("H3") ?? true)
    }

    func test_whenViewLoads_afterTwoHintUnlockDelay_shouldSpeakFirstAndSecondHint() {
        sut = RotorViewController(level: RotorLevel(clues: [], answers: ["A1", "A2"], validAnswers: [], hints: ["H1", "H2", "H3"]))
        sut.kHintUnlockTimeInterval = 0.1
        loadView()
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.4)
        
        sut.onHintsButtonTouched()

        XCTAssertEqual(accessibilitySpy.notification, .announcement)
        let spokenMessage = accessibilitySpy.argument as? String
        XCTAssertTrue(spokenMessage?.contains("H1") ?? false)
        XCTAssertTrue(spokenMessage?.contains("H2") ?? false)
        XCTAssertFalse(spokenMessage?.contains("H3") ?? true)
    }
    
}
