//
//  AppDelegate.swift
//  EscapeFromBlindness
//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator.start(window: self.window!)
        self.window?.rootViewController = self.appCoordinator.rootViewController

        self.window?.makeKeyAndVisible()
        
        return true
    }

}

