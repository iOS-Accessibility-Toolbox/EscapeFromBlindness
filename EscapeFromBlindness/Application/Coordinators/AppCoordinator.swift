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
    
    func presentIntroController()
    func presentGameController()
}

extension AppCoordinator: AppCoordinatorProtocol {}
extension AppCoordinator: UINavigationControllerDelegate {}

class AppCoordinator: NSObject, Coordinator {
    
    // MARK: - Initialization
    private var window: UIWindow?
    private let navigationController: UINavigationController = UINavigationController()
    
    var lastNavigationControllerViewController: UIViewController? {
        return self.navigationController.viewControllers.last
    }
    
    var children: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
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
        let currentLevelIndex = self.userDefaults.value(forKey: UserDefaultsKeys.currentLevelIndex.rawValue) as? Int ?? 0
        let currentChapter = getCurrentChapter(for: currentLevelIndex)
        
        if currentChapter == 0 {
            presentIntroController()
        } else {
            presentChapterController(currentChapter)
        }
    }
    
    private func getCurrentChapter(for currentLevelIndex: Int) -> Int {
        guard currentLevelIndex != 0 else { return 0 }
        let levelsPerChapter = 5
        return ((currentLevelIndex - 1) / levelsPerChapter) + 1
    }
    
    // MARK: - Intro
    internal var isPresentIntroControllerCalled = false
    
    func presentIntroController() {
        isPresentIntroControllerCalled = true
        let viewController = IntroViewController.fromXib()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Activate VoiceOver Alert
    internal var isVoiceOverAlertActive = false
    
    func showActivateVoiceOverAlert() {
        self.isVoiceOverAlertActive = true
        let activateVoiceAlertViewController = VoiceOverAlertViewController.fromXib()
        self.lastNavigationControllerViewController?.present(
            activateVoiceAlertViewController,
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
    
    func presentChapterController(_ chapter: Int) {
        isPresentChapterControllerCalled = true
        let viewController = ChapterViewController(chapter: chapter)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Game
    func presentGameController() {
        let viewController = UIViewController()
        viewController.view.frame = UIScreen.main.bounds
        viewController.view.backgroundColor = .green
        self.navigationController.pushViewController(viewController, animated: true)
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
