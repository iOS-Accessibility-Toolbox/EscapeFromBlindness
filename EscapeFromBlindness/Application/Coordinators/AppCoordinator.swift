//
//  Created by Michael Martinez on 26/06/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit
import CoreLocation

protocol AppCoordinatorProtocol: class {
    func start(window: UIWindow)
}

extension AppCoordinator: AppCoordinatorProtocol {}
extension AppCoordinator: UINavigationControllerDelegate {}

class AppCoordinator: NSObject, Coordinator {
    
    // MARK: - Initialization
    private var window: UIWindow?
    private let navigationController: UINavigationController = UINavigationController()
    
    private var controllers: [UIViewController] = []
    
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
    
    // MARK: - Onboarding
    func checkIfUserFirstStart() {
        let isFirstStart = self.userDefaults.value(forKey: UserDefaultsKeys.firstStart.rawValue) as? Bool ?? true

        if isFirstStart {
            presentOnboardingController()
        } else {
            presentGameController()
        }
    }
    
    func presentOnboardingController() {
        let viewController = UIViewController()
        viewController.view.frame = UIScreen.main.bounds
        viewController.view.backgroundColor = .orange
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
    @objc private func voiceOverStatusChanged() {
        print("VoiceOver status changed \(UIAccessibility.isVoiceOverRunning)")
    }
}
