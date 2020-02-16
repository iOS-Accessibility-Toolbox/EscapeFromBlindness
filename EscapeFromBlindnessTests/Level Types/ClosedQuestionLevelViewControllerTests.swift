//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class ClosedQuestionLevelViewControllerTests: XCTestCase {
    
    // MARK: - Test Variables
    var sut: ClosedQuestionViewController!
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
    
    // MARK: - Tests
    func test_viewDidLoad_withOneQuestion_shouldDisplayQuestion() {
        let level = ClosedQuestionLevel(
            question: "Q1",
            answers: ["A1,A2"],
            validAnswers: ["A1"]
        )
        sut = ClosedQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        
        XCTAssertEqual(sut.mainLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withOneQuestion_shouldDisplayAnswers() {
        let level = ClosedQuestionLevel(
            question: "Q1",
            answers: ["A1", "A2"],
            validAnswers: ["A1"]
        )
        sut = ClosedQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        
        XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(sut?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text, "A1")
        XCTAssertEqual(sut?.tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.text, "A2")
    }
    
    func test_viewDidLoad_withOneQuestion_andCorrectAnswerSelected_shouldDisplayAnswers() {
        let level = ClosedQuestionLevel(
            question: "Q1",
            answers: ["A1", "A2"],
            validAnswers: ["A1"]
        )
        sut = ClosedQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(coordinator?.validateAnswer, "A1")
        
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(coordinator?.validateAnswer, "A2")
    }
    
}
