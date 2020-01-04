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
    var presentGameControllerCalled = false
    
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
    
    func presentGameController() {
        presentGameControllerCalled = true
    }
}
