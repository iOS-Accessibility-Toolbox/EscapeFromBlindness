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
    
    func presentIntroController(_ scenario: InstructionsViewController.Scenario)
    func presentClosedQuestionController(_ level: Level)
    func presentOpenQuestionController(_ level: Level)
    func presentRotorQuestionController(_ level: Level)
    func presentSearchQuestionController(_ level: Level)
    
    func presentLoadLevelController()
    
    func validateChapter()
    func validate(_ answers: [Level.Answer])
    
    func loadLevel(_ chapterIndex: Int, levelIndex: Int)
    
    func replay()
}

class AppCoordinator: NSObject, Coordinator, AppCoordinatorProtocol {
    
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
    private let soundPlayer: SoundPlayerProtocol
    
    init(
        userDefaults: UserDefaults = UserDefaults.standard,
        gameFlow: GameFlowProtocol,
        soundPlayer: SoundPlayerProtocol = SoundPlayer()
    ) {
        self.userDefaults = userDefaults
        self.gameFlow = gameFlow
        self.soundPlayer = soundPlayer
    }
    
    func start(window: UIWindow) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(voiceOverStatusChanged),
            name: UIAccessibility.voiceOverStatusDidChangeNotification,
            object: nil
        )
        
        self.window = window
        
        checkIfUserFirstStart()
    }
    
    private func checkIfUserFirstStart() {
        let currentChapter = gameFlow.getCurrentChapterIndex()

        if currentChapter == 0 {
            presentIntroController(.intro)
        } else {
            //gameFlow.start()
            presentLoadLevelController()
        }
    }
    
    internal var isPresentLoadLevelControllerCalled = false
    func presentLoadLevelController() {
        isPresentLoadLevelControllerCalled = true
        let viewController = LoadLevelViewController(
            chapters: gameFlow.getChapters(),
            currentChapterIndex: gameFlow.getCurrentChapterIndex(),
            currentLevelIndex: gameFlow.getCurrentLevelIndex()
        )
        viewController.coordinator = self
        
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [viewController]
    }
    
    private var SELECTED: (Int, Int)? = nil
    func loadLevel(_ chapterIndex: Int, levelIndex: Int) {
        self.SELECTED = (chapterIndex, levelIndex)
        gameFlow.loadLevel(chapterIndex, levelIndex)
    }
    
    // MARK: - Intro
    internal var isPresentIntroControllerCalled = false
    
    func presentIntroController(_ scenario: InstructionsViewController.Scenario) {
        isPresentIntroControllerCalled = true
        let viewController = InstructionsViewController.fromXib()
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
        
        let chapterTitle = gameFlow.getTitleForChapter(chapterIndex: self.SELECTED?.0)
        let levelIndex = gameFlow.getCurrentLevelIndex(levelIndex: self.SELECTED?.1)
        viewController.navigationItem.title = "\(chapterTitle != nil ? "\(chapterTitle!)" : "\(L10n.level) \(levelIndex + 1)")"
        viewController.navigationItem.accessibilityLabel = "\(chapterTitle != nil ? "\(chapterTitle!) - " : "")\(L10n.level) \(levelIndex + 1)"
        
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Actions
    @objc internal func voiceOverStatusChanged() {
        let isNonIntroViewController = !(self.lastNavigationControllerViewController is InstructionsViewController)
        let isVoiceOverRunning = EscapeFromBlindnessAccessibility.shared.isVoiceOverRunning
        
        if isNonIntroViewController && !isVoiceOverRunning {
            self.showActivateVoiceOverAlert()
        }
    }
}

extension AppCoordinator {
    func validateChapter() {
        gameFlow.validateChapter()
    }
    
    func validate(_ answers: [String]) {
        gameFlow.validate(answers)
    }
}

extension AppCoordinator: Router {
    func routeToChapter(_ chapter: Chapter, isNewChapter: Bool) {
        if isNewChapter {
            userDefaults.set(chapter.index, forKey: UserDefaultsKeys.currentChapterIndex.rawValue)
            userDefaults.set(0, forKey: UserDefaultsKeys.currentLevelIndex.rawValue)
        }
        
        presentChapterController(chapter)
        playAmbiantSound(for: chapter)
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
        default:
            break
        }
    }
    
    func routeToResults() {
        self.presentIntroController(.gameEnd)
    }
    
    private func playAmbiantSound(for chapter: Chapter) {
        soundPlayer.stop()
        // ensure there is always an ambiant sound playing
        let type = CustomSoundTypes.allCases[(chapter.index - 1) % CustomSoundTypes.allCases.count]
        soundPlayer.start(type: type)
    }
}
