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
    
}

