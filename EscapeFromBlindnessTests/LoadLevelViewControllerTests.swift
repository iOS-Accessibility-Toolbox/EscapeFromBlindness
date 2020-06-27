//
//  Created by Michael Martinez on 21/04/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class LoadLevelViewControllerTests: XCTestCase {
    
    var sut: LoadLevelViewController!
    var window: UIWindow!
    var coordinator: AppCoordinatorSpy!
    var accessibilitySpy: AccessibilityNotificationCenterSpy!
    
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    private let chapters = LocalLevelFactory.build()
    private let currentChapter = 1
    private let currentLevel = 2
    
    private func setupSUT() {
        window = UIWindow()
        sut = LoadLevelViewController(chapters: chapters, currentChapterIndex: currentChapter, currentLevelIndex: currentLevel)
        self.coordinator = AppCoordinatorSpy()
        sut.coordinator = coordinator
        self.accessibilitySpy = AccessibilityNotificationCenterSpy()
        EscapeFromBlindnessAccessibility.shared = accessibilitySpy
    }
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func unloadView() {
        sut.view.removeFromSuperview()
    }
    
    func test_shouldDisplayOneSectionPerChapter() {
        sut.loadView()
        
        XCTAssertEqual(sut.numberOfSections(in: sut.collectionView), chapters.count)
    }
    
    func test_shouldDisplayAllLevelsInSections() {
        sut.loadView()
        
        for i in 0..<chapters.count {
            XCTAssertEqual(sut.collectionView(sut.collectionView, numberOfItemsInSection: i), chapters[i].levels.count)
        }
    }
    
    func test_unlockedLevelSelected_shouldLoadCorrespondingLevel() {
        sut.loadView()
        
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: 2, section: 0))
        
        XCTAssertEqual(coordinator.loadedChapterLevel?.0, 0)
        XCTAssertEqual(coordinator.loadedChapterLevel?.1, 2)
    }
    
    func test_lockedLevelSelected_shouldLoadCorrespondingLevel() {
        sut.loadView()
        
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: 2, section: 2))
        
        XCTAssertNil(coordinator.loadedChapterLevel)
    }
    
    func test_viewDidLoad_shouldFocusCurrentLevel() {
        sut.viewDidAppear(false)
        
        XCTAssertEqual(accessibilitySpy.notification, .layoutChanged)
    }
    
}
