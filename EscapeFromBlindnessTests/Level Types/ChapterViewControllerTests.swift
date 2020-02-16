//
//  ChapterViewControllerTests.swift
//  EscapeFromBlindnessTests
//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class ChapterViewControllerTests: XCTestCase {
    
    // MARK: Test Variables
    var sut: ChapterViewController!
    var coordinator: AppCoordinatorSpy!
    var accessibilityNotificationCenterSpy: AccessibilityNotificationCenterSpy!
    var window: UIWindow!
    private let chapter = Chapter(index: 2, levels: [])
    
    // MARK: Test Lifecycle
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func test_viewDidLoadAndVoiceOverDisabled_shouldPresentVoiceOverAlert() {
        accessibilityNotificationCenterSpy.isVoiceOverRunning = false
        loadView()
        
        XCTAssertTrue(coordinator.showActivateVoiceOverAlertCalled)
    }
    
    func test_viewDidLoadAndVoiceOverEnabled_shouldNotPresentVoiceOverAlert() {
        accessibilityNotificationCenterSpy.isVoiceOverRunning = true
        loadView()
        
        XCTAssertFalse(coordinator.showActivateVoiceOverAlertCalled)
    }
    
    func test_viewDidLoad_shouldDisplayChapter() {
        loadView()
        
        XCTAssertTrue(sut.chapterLabel.text!.contains("\(chapter)"))
    }
    
    func test_onContinueButtonTouched_shouldPresentGameViewController() {
        loadView()
        
        sut.continueButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(coordinator.validateChapterCalled)
    }
    
    // MARK: Private Methods
    private func setupSUT() {
        window = UIWindow()
        coordinator = AppCoordinatorSpy()
        accessibilityNotificationCenterSpy = AccessibilityNotificationCenterSpy()
        
        sut = ChapterViewController(chapter: chapter)
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
    
}
