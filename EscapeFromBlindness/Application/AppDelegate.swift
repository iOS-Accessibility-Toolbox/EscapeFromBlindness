//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let chapters = LocalLevelFactory.build()
        let currentChapterIndex = UserDefaults.standard.value(forKey: UserDefaultsKeys.currentChapterIndex.rawValue) as? Int ?? 0
        let currentLevelIndex = UserDefaults.standard.value(forKey: UserDefaultsKeys.currentLevelIndex.rawValue) as? Int ?? 0
        
        let gameFlow = GameFlow(
            chapters: chapters,
            currentChapterIndex: currentChapterIndex,
            currentLevelIndex: currentLevelIndex
        )
        self.appCoordinator = AppCoordinator(gameFlow: gameFlow)
        gameFlow.router = self.appCoordinator!
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.appCoordinator?.start(window: window)
        self.window?.rootViewController = self.appCoordinator?.rootViewController

        self.window?.makeKeyAndVisible()
        
        return true
    }

}
