//
//  AppDelegate.swift
//  GDPR Example
//
//  Created by Lyn Almasri on 17.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import GDPR
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GDPRDelegate {
    func termsAndConditionsAccepted() {
        print("Terms accepted")
    }
    
    func serviceValueDidChange(id: String, value: Bool) {
        print("service: \(id) changed value to \(value)")
    }
    
    func deleteDate(id: String) {
        print("Data deleted: \(id)")
    }
    
    public var gdprManager: GDPRManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        gdprManager = GDPRManager.shared
        gdprManager?.setURLs(termsURL: Bundle.main.url(forResource: "terms_of_service", withExtension: "html")!, privacyPolicyURL: Bundle.main.url(forResource: "privacy_policy", withExtension: "html")!)
        gdprManager?.delegate = self
        
        gdprManager?.setService(id: "S1", name: "Firebase", description: "Something about Firebase", supportDeletion: true)
        gdprManager?.setService(id: "S2", name: "Crashlytics", description: "Something about Crashlytics", supportDeletion: false)

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
