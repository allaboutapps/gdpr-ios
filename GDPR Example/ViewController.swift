//
//  ViewController.swift
//  GDPR Example
//
//  Created by Lyn Almasri on 17.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import GDPR
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Example App"
    }

    @IBAction func presentTos(_ sender: Any) {
        let manager = GDPRManager.shared
        let hostingView = UIHostingController(rootView: manager.presentConformationForm(showTermsOfService: true, showSettings: false))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    @IBAction func presentTosAndSettings(_ sender: Any) {
        let manager = GDPRManager.shared
        let hostingView = UIHostingController(rootView: manager.presentConformationForm(showTermsOfService: true, showSettings: true))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    @IBAction func trackingSettings(_ sender: Any) {
        let manager = GDPRManager.shared
        let hostingView = UIHostingController(rootView: manager.presentSettings())
        navigationController?.pushViewController(hostingView, animated: true)
    }

    @IBAction func trackingSettingsWithTos(_ sender: Any) {
        let manager = GDPRManager.shared
        let hostingView = UIHostingController(rootView: manager.presentSettings(showTOS: true))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    @IBAction func privacyPolicy(_ sender: Any) {}

    @IBAction func termsOfService(_ sender: Any) {}

    @IBAction func privacyChangedAlarm(_ sender: Any) {}
}
