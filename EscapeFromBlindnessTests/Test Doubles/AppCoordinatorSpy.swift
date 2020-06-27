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
    var replayCalled = false
    var showActivateVoiceOverAlertCalled = false
    var dismissActivateVoiceOverAlertCalled = false
    
    var presentIntroControllerScenario: InstructionsViewController.Scenario?
    var presentChapterControllerCalled = false
    
    var loadedChapterLevel: (Int, Int)?
    
    func presentLoadLevelController() {}
    func loadLevel(_ chapterIndex: Int, levelIndex: Int) {
        loadedChapterLevel = (chapterIndex, levelIndex)
    }
    
    func start(window: UIWindow) {
        startCalled = true
    }
    
    func replay() {
        replayCalled = true
    }
    
    func showActivateVoiceOverAlert() {
        showActivateVoiceOverAlertCalled = true
    }
    
    func dismissActivateVoiceOverAlert() {
        dismissActivateVoiceOverAlertCalled = true
    }
    
    func presentIntroController(_ scenario: InstructionsViewController.Scenario) {
        presentIntroControllerScenario = scenario
    }
    
    func presentChapterController(_ chapter: Chapter) {
        presentChapterControllerCalled = true
    }
    
    // Game
    var presentClosedQuestionControllerCalled = false
    var presentOpenQuestionControllerCalled = false
    var presentRotorQuestionControllerCalled = false
    var presentSearchQuestionControllerCalled = false
    
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
    
    // Validation
    var validateChapterCalled = false
    var validateAnswers: [Level.Answer]?
    
    func validateChapter() {
        validateChapterCalled = true
    }
    
    func validate(_ answers: [Level.Answer]) {
        validateAnswers = answers
    }
}
