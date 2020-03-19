//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class OpenQuestionLevelViewControllerTests: XCTestCase {
    
    // MARK: - Test Variables
    var sut: OpenQuestionViewController!
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
        let level = OpenQuestionLevel(
            question: "Q1",
            validAnswers: ["A1"]
        )
        sut = OpenQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        
        XCTAssertEqual(sut.mainLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withOneQuestion_andAnswerWritten_shouldValidateLowercasedAnswer() {
        let level = OpenQuestionLevel(
            question: "Q1",
            validAnswers: ["a1"]
        )
        sut = OpenQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        sut.textField.becomeFirstResponder()
        sut.textField.text = "A2é"
        sut.textField.endEditing(false)
        
        XCTAssertEqual(coordinator?.validateAnswers, ["a2e"])
    }
    
    func test_viewDidLoad_withOneQuestion_andAnswerWritten_shouldValidateWhitespaceTrimmedAnswer() {
        let level = OpenQuestionLevel(
            question: "Q1",
            validAnswers: ["a1"]
        )
        sut = OpenQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        sut.textField.becomeFirstResponder()
        sut.textField.text = "A2e "
        sut.textField.endEditing(false)
        
        XCTAssertEqual(coordinator?.validateAnswers, ["a2e"])
    }
    
    func test_viewDidLoad_withOneQuestion_andAnswerWritten_shouldValidateNewlinesTrimmedAnswer() {
        let level = OpenQuestionLevel(
            question: "Q1",
            validAnswers: ["a1"]
        )
        sut = OpenQuestionViewController(level: level)
        sut.coordinator = coordinator
        
        loadView()
        sut.textField.becomeFirstResponder()
        sut.textField.text = "A2e\n"
        sut.textField.endEditing(false)
        
        XCTAssertEqual(coordinator?.validateAnswers, ["a2e"])
    }
    
}
