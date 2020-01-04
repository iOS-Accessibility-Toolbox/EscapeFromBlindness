//
//  IntroViewControllerTests.swift
//  EscapeFromBlindnessTests
//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class IntroViewControllerTests: XCTestCase {
    
    // MARK: Test Variables
    var sut: IntroViewController!
    var window: UIWindow!
    
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
        let bundle = Bundle.main
        sut = IntroViewController.fromXib(bundle: bundle)
    }
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func unloadView() {
        sut.view.removeFromSuperview()
    }
    
}
