//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

protocol Router {
    func routeToLevel(_ question: Level)
    func routeToResults()
}

class GameFlow {
    private let levels: [Level]
    private let router: Router
    
    private var currentLevelIndex = 0
    
    init(levels: [Level], router: Router) {
        self.levels = levels
        self.router = router
    }
    
    func start() {
        routeToLevel(at: 0)
    }
    
    func next(_ answer: Level.Answer) {
        if validateAnswer(answer) {
            currentLevelIndex += 1
            routeToLevel(at: currentLevelIndex)
        }
    }
    
    private func validateAnswer(_ answer: Level.Answer) -> Bool {
        return self.levels[safe: self.currentLevelIndex]?.validAnswers.contains(answer) ?? false
    }
    
    private func routeToLevel(at index: Int) {
        if let nextLevel = self.levels[safe: index] {
            router.routeToLevel(nextLevel)
        } else {
            router.routeToResults()
        }
    }
}

protocol Level {
    typealias Answer = String
    var answers: [Answer] { get set }
    var validAnswers: [Answer] { get set }
}

struct ClosedQuestion: Level {
    var answers: [Answer]
    var validAnswers: [Answer]
}
extension ClosedQuestion: Equatable {}

class GameFlowTests: XCTestCase {
    
    // MARK: - Test Variables
    var sut: GameFlow!
    
    // MARK: - Tests
    func test_gameFlow_withNoQuestions_startCalled_shouldRouteToResultsScreen() {
        let routerSpy = RouterSpy()
        sut = GameFlow(levels: [], router: routerSpy)
        
        sut.start()
        
        XCTAssertTrue(routerSpy.routeToResultsCalled)
    }
    
    func test_gameFlow_withOneQuestion_startCalled_shouldRouteToCorrectQuestion() {
        let routerSpy = RouterSpy()
        let question = ClosedQuestion(answers: [], validAnswers: [])
        sut = GameFlow(levels: [question], router: routerSpy)
        
        sut.start()
        
        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestion, question)
    }
    
    func test_gameFlow_withOneQuestion_startCalledTwice_shouldRouteToCorrectQuestion() {
        let routerSpy = RouterSpy()
        let question = ClosedQuestion(answers: [], validAnswers: [])
        sut = GameFlow(levels: [question], router: routerSpy)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestion, question)
    }
    
    func test_gameFlow_withTwoQuestions_withWrongAnswer_shouldNotRouteToCorrectQuestion() {
        let routerSpy = RouterSpy()
        let firstQuestion = ClosedQuestion(answers: ["A1", "A2"], validAnswers: ["A1"])
        let secondQuestion = ClosedQuestion(answers: [], validAnswers: [])
        sut = GameFlow(
            levels: [firstQuestion, secondQuestion],
            router: routerSpy
        )
        
        sut.start()
        sut.next("A2")
        
        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestion, firstQuestion)
    }
    
    func test_gameFlow_withTwoQuestions_withValidAnswer_shouldRouteToCorrectQuestion() {
        let routerSpy = RouterSpy()
        let firstQuestion = ClosedQuestion(answers: ["A1", "A2"], validAnswers: ["A1"])
        let secondQuestion = ClosedQuestion(answers: [], validAnswers: [])
        sut = GameFlow(
            levels: [firstQuestion, secondQuestion],
            router: routerSpy
        )
        
        sut.start()
        sut.next("A1")
        
        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestion, secondQuestion)
    }
    
    // MARK: - Test Doubles
    class RouterSpy: Router {
        var routeToResultsCalled = false
        var capturedLevel: Level?
        
        func routeToLevel(_ level: Level) {
            capturedLevel = level
        }
        
        func routeToResults() {
            routeToResultsCalled = true
        }
    }
    
}
