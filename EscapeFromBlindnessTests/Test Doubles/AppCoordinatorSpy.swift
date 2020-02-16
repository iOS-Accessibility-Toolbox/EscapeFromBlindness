//
//  AppCoordinatorSpy.swift
//  EscapeFromBlindnessTests
//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit
@testable import EscapeFromBlindness

class AppCoordinatorSpy: AppCoordinatorProtocol {
    var startCalled = false
    var showActivateVoiceOverAlertCalled = false
    var dismissActivateVoiceOverAlertCalled = false
    
    var presentIntroControllerCalled = false
    var presentChapterControllerCalled = false
    
    func start(window: UIWindow) {
        startCalled = true
    }
    
    func showActivateVoiceOverAlert() {
        showActivateVoiceOverAlertCalled = true
    }
    
    func dismissActivateVoiceOverAlert() {
        dismissActivateVoiceOverAlertCalled = true
    }
    
    func presentIntroController() {
        presentIntroControllerCalled = true
    }
    
    func presentChapterController(_ chapter: Chapter) {
        presentChapterControllerCalled = true
    }
    
    // Game
    var presentClosedQuestionControllerCalled = false
    var presentOpenQuestionControllerCalled = false
    var presentRotorQuestionControllerCalled = false
    var presentSearchQuestionControllerCalled = false
    var presentMazeQuestionControllerCalled = false
    
    func presentClosedQuestionController(_ level: Level) {
        presentClosedQuestionControllerCalled = true
    }
    
    func presentOpenQuestionController(_ level: Level) {
        presentOpenQuestionControllerCalled = true
    }
    
    func presentRotorQuestionController(_ level: Level) {
        presentRotorQuestionControllerCalled = true
    }
    
    func presentSearchQuestionController(_ level: Level) {
        presentSearchQuestionControllerCalled = true
    }
    
    func presentMazeQuestionController(_ level: Level) {
        presentMazeQuestionControllerCalled = true
    }
    
    // Validation
    var validateChapterCalled = false
    var validateAnswer: Level.Answer?
    
    func validateChapter() {
        validateChapterCalled = true
    }
    
    func validate(_ answer: Level.Answer) {
        validateAnswer = answer
    }
}
