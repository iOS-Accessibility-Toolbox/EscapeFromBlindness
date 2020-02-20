//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class SearchLevelViewControllerTests: XCTestCase {
    
    // MARK: - Test Variables
    var sut: SearchViewController!
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
        accessibilityNotificationCenterSpy = AccessibilityNotificationCenterSpy()
        coordinator = AppCoordinatorSpy()
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
//    levelDescription: "There is a level system in front of of you...",
//    levelActions: [
//        (actions: ["There is a lever on your left"], results: ["turn it left", "let it in the center", "turn it right"]),
//        (actions: ["There is a lever in the center of the place"], results: ["turn it left", "let it in the center", "turn it right"]),
//        (actions: ["There is a lever on your right"], results: ["turn it left", "let it in the center", "turn it right"])
//    ],
//    validActions: ["turn it left", "let it in the center", "turn it right"]
    
    func test_whenViewLoads_shouldDisplayLevelDescription() {
        let levelDescription = "There is a level system in front of of you..."
        let level = SearchLevel(
            levelDescription: levelDescription,
            levelActions: [
                (description: "", actions: ["There is a lever on your left"], results: ["turn it left", "let it in the center", "turn it right"]),
                (description: "", actions: ["There is a lever in the center of the place"], results: ["turn it left", "let it in the center", "turn it right"]),
                (description: "", actions: ["There is a lever on your right"], results: ["turn it left", "let it in the center", "turn it right"])
            ],
            validActions: ["turn it left", "let it in the center", "turn it right"]
        )!
        sut = SearchViewController(level: level)
        
        loadView()
        
        XCTAssertEqual(sut.mainLabel.text, levelDescription)
    }
    
    func test_whenViewLoads_shouldDisplayActionsDescriptions() {
        let levelDescription = "There is a level system in front of of you..."
        let level = SearchLevel(
            levelDescription: levelDescription,
            levelActions: [
                (description: "D1", actions: ["There is a lever on your left"], results: ["turn it left", "let it in the center", "turn it right"]),
                (description: "D2", actions: ["There is a lever in the center of the place"], results: ["turn it left", "let it in the center", "turn it right"]),
                (description: "D3", actions: ["There is a lever on your right"], results: ["turn it left", "let it in the center", "turn it right"])
            ],
            validActions: ["turn it left", "let it in the center", "turn it right"]
        )!
        sut = SearchViewController(level: level)
        
        loadView()
        
        XCTAssertEqual(sut.actionViews[0].accessibilityLabel, "D1")
        XCTAssertEqual(sut.actionViews[1].accessibilityLabel, "D2")
        XCTAssertEqual(sut.actionViews[2].accessibilityLabel, "D3")
    }
    
    func test_whenViewLoads_shouldDisplayActions() {
        let levelDescription = "There is a level system in front of of you..."
        let level = SearchLevel(
            levelDescription: levelDescription,
            levelActions: [
                (description: "D1", actions: ["A1", "A2", "A3"], results: ["R1", "R2", "R3"]),
                (description: "D2", actions: ["B1", "B2", "B3"], results: ["R1", "R2", "R3"]),
                (description: "D3", actions: ["C1", "C2", "C3"], results: ["R1", "R2", "R3"])
            ],
            validActions: ["A1", "B2", "C3"]
        )!
        sut = SearchViewController(level: level)

        loadView()

        XCTAssertEqual(sut.actionViews[0].accessibilityCustomActions![0].name, "A1")
        XCTAssertEqual(sut.actionViews[0].accessibilityCustomActions![1].name, "A2")
        XCTAssertEqual(sut.actionViews[0].accessibilityCustomActions![2].name, "A3")

        XCTAssertEqual(sut.actionViews[1].accessibilityCustomActions![0].name, "B1")
        XCTAssertEqual(sut.actionViews[1].accessibilityCustomActions![1].name, "B2")
        XCTAssertEqual(sut.actionViews[1].accessibilityCustomActions![2].name, "B3")

        XCTAssertEqual(sut.actionViews[2].accessibilityCustomActions![0].name, "C1")
        XCTAssertEqual(sut.actionViews[2].accessibilityCustomActions![1].name, "C2")
        XCTAssertEqual(sut.actionViews[2].accessibilityCustomActions![2].name, "C3")
    }
    
    func test_whenViewLoads_shouldValidateActionsResults() {
        let levelDescription = "There is a level system in front of of you..."
        let level = SearchLevel(
            levelDescription: levelDescription,
            levelActions: [
                (description: "D1", actions: ["A1", "A2", "A3"], results: ["AR1", "AR2", "AR3"]),
                (description: "D2", actions: ["B1", "B2", "B3"], results: ["BR1", "BR2", "BR3"]),
                (description: "D3", actions: ["C1", "C2", "C3"], results: ["CR1", "CR2", "CR3"])
            ],
            validActions: ["AR1", "BR2", "CR3"]
        )!
        sut = SearchViewController(level: level)
        loadView()
        
        let customAction = UIAccessibilityCustomAction(name: "B2", target: nil, selector: #selector(stubSelector))
        _ = sut.performAction(action: customAction)
        
        XCTAssertEqual(accessibilityNotificationCenterSpy.notification, .announcement)
        XCTAssertEqual(accessibilityNotificationCenterSpy.argument as! String, "BR2")
    }
    
    @objc private func stubSelector() {}
    
}
