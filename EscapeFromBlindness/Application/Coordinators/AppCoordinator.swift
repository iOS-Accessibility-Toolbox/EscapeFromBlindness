//
//  Created by Michael Martinez on 26/06/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit
import CoreLocation

protocol AppCoordinatorProtocol: class {
    func start(window: UIWindow)
    func showActivateVoiceOverAlert()
    func dismissActivateVoiceOverAlert()
    
    func presentIntroController(_ scenario: IntroViewController.Scenario)
    func validateChapter()
    func validate(_ answers: [Level.Answer])
    
    func presentClosedQuestionController(_ level: Level)
    func presentOpenQuestionController(_ level: Level)
    func presentRotorQuestionController(_ level: Level)
    func presentSearchQuestionController(_ level: Level)
    func presentMazeQuestionController(_ level: Level)
    
    func replay()
}

extension AppCoordinator: AppCoordinatorProtocol {
    func validateChapter() {
        gameFlow.validateChapter()
    }
    
    func validate(_ answers: [String]) {
        gameFlow.validate(answers)
    }
}
extension AppCoordinator: UINavigationControllerDelegate {}

extension AppCoordinator: Router {
    
    func routeToChapter(_ chapter: Chapter, isNewChapter: Bool) {
        if isNewChapter {
            userDefaults.set(chapter.index, forKey: UserDefaultsKeys.currentChapterIndex.rawValue)
            userDefaults.set(0, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)
        }
        presentChapterController(chapter)
    }
    
    func routeToLevel(_ level: Level) {
        let currentLevel = gameFlow.getCurrentLevelIndex()
        userDefaults.set(currentLevel, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)
        
        switch level {
        case is ClosedQuestionLevel:
            presentClosedQuestionController(level)
        case is OpenQuestionLevel:
            presentOpenQuestionController(level)
        case is RotorLevel:
            presentRotorQuestionController(level)
        case is SearchLevel:
            presentSearchQuestionController(level)
        case is MazeLevel:
            presentMazeQuestionController(level)
        default:
            break
        }
    }
    
    func routeToResults() {
        print("routeToResults")
        self.presentIntroController(.gameEnd)
    }
    
}

class AppCoordinator: NSObject, Coordinator {
    
    // MARK: - Initialization
    private var window: UIWindow?
    internal let navigationController = NavigationController()
    
    var lastNavigationControllerViewController: UIViewController? {
        return self.navigationController.viewControllers.last
    }
    
    var children: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private let userDefaults: UserDefaults
    private let gameFlow: GameFlowProtocol
    
    init(
        userDefaults: UserDefaults = UserDefaults.standard,
        gameFlow: GameFlowProtocol
    ) {
        self.userDefaults = userDefaults
        self.gameFlow = gameFlow
    }
    
    func start(window: UIWindow) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(voiceOverStatusChanged),
            name: UIAccessibility.voiceOverStatusDidChangeNotification,
            object: nil
        )
        
        self.window = window
        navigationController.delegate = self
        
        checkIfUserFirstStart()
    }
    
    private func checkIfUserFirstStart() {
        let currentChapter = gameFlow.getCurrentChapterIndex()

        if currentChapter == 0 {
            presentIntroController(.intro)
        } else {
            gameFlow.start()
        }
    }
    
    // MARK: - Intro
    internal var isPresentIntroControllerCalled = false
    
    func presentIntroController(_ scenario: IntroViewController.Scenario) {
        isPresentIntroControllerCalled = true
        let viewController = IntroViewController.fromXib()
        viewController.scenario = scenario
        viewController.coordinator = self
        
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Activate VoiceOver Alert
    internal var isVoiceOverAlertActive = false
    
    func showActivateVoiceOverAlert() {
        self.isVoiceOverAlertActive = true
        let viewController = VoiceOverAlertViewController.fromXib()
        viewController.coordinator = self
        self.lastNavigationControllerViewController?.present(
            viewController,
            animated: false,
            completion: nil
        )
    }
    
    func dismissActivateVoiceOverAlert() {
        self.isVoiceOverAlertActive = false
        self.lastNavigationControllerViewController?.dismiss(
            animated: true, completion: nil
        )
    }
    
    // MARK: - Chapter
    internal var isPresentChapterControllerCalled = false
    
    func presentChapterController(_ chapter: Chapter) {
        isPresentChapterControllerCalled = true
        let viewController = ChapterViewController(chapter: chapter)
        viewController.coordinator = self
        
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Game
    func presentClosedQuestionController(_ level: Level) {
        guard let level = level as? ClosedQuestionLevel else { return }
        
        let viewController = ClosedQuestionViewController(level: level)
        viewController.coordinator = self
        
        resetNavigationStack(viewController)
    }
    
    func presentOpenQuestionController(_ level: Level) {
        guard let level = level as? OpenQuestionLevel else { return }
        
        let viewController = OpenQuestionViewController(level: level)
        viewController.coordinator = self
        
        resetNavigationStack(viewController)
    }
    
    func presentRotorQuestionController(_ level: Level) {
        guard let level = level as? RotorLevel else { return }
        
        let viewController = RotorViewController(level: level)
        viewController.coordinator = self
        
        resetNavigationStack(viewController)
    }
    
    func presentSearchQuestionController(_ level: Level) {
        guard let level = level as? SearchLevel else { return }
        
        let viewController = SearchViewController(level: level)
        viewController.coordinator = self
        
        resetNavigationStack(viewController)
    }
    
    func presentMazeQuestionController(_ level: Level) {
        guard let level = level as? MazeLevel else { return }
        
        let viewController = MazeViewController(level: level)
        viewController.coordinator = self
        
        resetNavigationStack(viewController)
    }
    
    // MARK: - Replay
    func replay() {
        guard let window = window else { return }
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentChapterIndex.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentLevelIndex.rawValue)
        self.gameFlow.restart()
        self.start(window: window)
    }
    
    // MARK: - Private Methods
    private func resetNavigationStack(_ viewController: UIViewController) {
        navigationController.isNavigationBarHidden = false
        let levelIndex = gameFlow.getCurrentLevelIndex()
        viewController.navigationItem.title = "Level \(levelIndex + 1)"
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Actions
    @objc internal func voiceOverStatusChanged() {
        let isNonIntroViewController = !(self.lastNavigationControllerViewController is IntroViewController)
        let isVoiceOverRunning = EscapeFromBlindnessAccessibility.shared.isVoiceOverRunning
        
        if isNonIntroViewController && !isVoiceOverRunning {
            self.showActivateVoiceOverAlert()
        }
    }
}
