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
    let manager = GDPRManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Example App"
    }

    // Show settings without confirmation button
    @IBAction func showSettings(_ sender: Any) {
        let hostingView = UIHostingController(rootView: manager.showSettings(title: "Legal Settings"))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    // Show Setting with confirmation button
    @IBAction func showForm(_ sender: Any) {
        let hostingView = UIHostingController(rootView: manager.showForm(title: "Legal Settings", onConfirm: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            print("Confirmed!")
        }))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    @IBAction func privacyChangedAlarm(_ sender: Any) {
        manager.updateLatestPolicyTimestamp(date: Date())
        if manager.shouldPresentTOS() {
            let alert = manager.showAlert(title: "Legal Settings") { [weak self] view in
                let hostingView = UIHostingController(rootView: view)
                self?.navigationController?.pushViewController(hostingView, animated: true)
            }
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func acceptTerms(_ sender: Any) {
        manager.acceptTermsAndPolicy()
    }
}
