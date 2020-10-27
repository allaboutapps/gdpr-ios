//
//  AppDelegate.swift
//  GDPR Example
//
//  Created by Lyn Almasri on 17.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import UIKit
import GDPR

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GDPRManager.shared.setService(id: "S1", name: "Firebase", description: "Something about Firebase", supportDeletion: true)
        GDPRManager.shared.setService(id: "S2", name: "Crashlytics", description: "Something about Crashlytics", supportDeletion: false)
        GDPRManager.shared.setService(id: "S3", name: "Crashlytics", description: "Something about Crashlytics", supportDeletion: false)
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

}
