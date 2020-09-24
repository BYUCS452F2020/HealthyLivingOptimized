//
//  AppDelegate.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Loggin
        setupLogging()
        
        /// Keyboard
        KeyboardOptionsManager.start()
        
        /// AWS
        AWSManager.shared.start()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    /// For debugging
    func setupLogging() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }


}

