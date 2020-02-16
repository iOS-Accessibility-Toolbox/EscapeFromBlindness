////
////  Created by Michael Martinez on 26/12/2019.
////  Copyright © 2019 michael-martinez. All rights reserved.
////
//
//import Foundation
//import XCTest
//@testable import EscapeFromBlindness
//
//class GameFlowTests: XCTestCase {
//    
//    // MARK: - Test Variables
//    var sut: GameFlow!
//    
//    // MARK: - Tests
//    func test_gameFlow_withNoQuestions_startCalled_shouldRouteToResultsScreen() {
//        let routerSpy = RouterSpy()
//        sut = GameFlow(levels: [], currentLevelIndex: 0)
//        sut.router = routerSpy
//        
//        sut.start()
//        
//        XCTAssertTrue(routerSpy.routeToResultsCalled)
//    }
//    
//    func test_gameFlow_withOneQuestion_startCalled_shouldRouteToCorrectQuestion() {
//        let routerSpy = RouterSpy()
//        let question = ClosedQuestionLevel(question: "", answers: [], validAnswers: [])
//        sut = GameFlow(levels: [question], currentLevelIndex: 0)
//        sut.router = routerSpy
//        
//        sut.start()
//        
//        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestionLevel, question)
//    }
//    
//    func test_gameFlow_withOneQuestion_startCalledTwice_shouldRouteToCorrectQuestion() {
//        let routerSpy = RouterSpy()
//        let question = ClosedQuestionLevel(question: "", answers: [], validAnswers: [])
//        sut = GameFlow(levels: [question], currentLevelIndex: 0)
//        sut.router = routerSpy
//        
//        sut.start()
//        sut.start()
//        
//        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestionLevel, question)
//    }
//    
//    func test_gameFlow_withTwoQuestions_withWrongAnswer_shouldNotRouteToCorrectQuestion() {
//        let routerSpy = RouterSpy()
//        let firstQuestion = ClosedQuestionLevel(question: "", answers: ["A1", "A2"], validAnswers: ["A1"])
//        let secondQuestion = ClosedQuestionLevel(question: "", answers: [], validAnswers: [])
//        sut = GameFlow(
//            levels: [firstQuestion, secondQuestion],
//            currentLevelIndex: 0
//        )
//        sut.router = routerSpy
//        
//        sut.start()
//        sut.validate("A2")
//        
//        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestionLevel, firstQuestion)
//    }
//    
//    func test_gameFlow_withTwoQuestions_withValidAnswer_shouldRouteToCorrectQuestion() {
//        let routerSpy = RouterSpy()
//        let firstQuestion = ClosedQuestionLevel(question: "", answers: ["A1", "A2"], validAnswers: ["A1"])
//        let secondQuestion = ClosedQuestionLevel(question: "", answers: [], validAnswers: [])
//        sut = GameFlow(
//            levels: [firstQuestion, secondQuestion],
//            currentLevelIndex: 0
//        )
//        sut.router = routerSpy
//        
//        sut.start()
//        sut.validate("A1")
//        
//        XCTAssertEqual(routerSpy.capturedLevel as? ClosedQuestionLevel, secondQuestion)
//    }
//    
//    // MARK: - Test Doubles
//    class RouterSpy: Router {
//        var routeToResultsCalled = false
//        var capturedLevel: Level?
//        
//        func routeToLevel(_ level: Level) {
//            capturedLevel = level
//        }
//        
//        func routeToResults() {
//            routeToResultsCalled = true
//        }
//    }
//    
//}
