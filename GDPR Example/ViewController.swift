//
//  ViewController.swift
//  GDPR Example
//
//  Created by Lyn Almasri on 17.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI
import GDPR

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func presentTos(_ sender: Any) {
        let manager = GDPRManager.shared
        let hostingView = UIHostingController(rootView: manager.presentConformationForm(requireTOS: true, showSettings: true))
        navigationController?.pushViewController(hostingView, animated: true)
    }
    @IBAction func presentTosAndSettings(_ sender: Any) {
        let service = ServiceModel(id: "S1", name: "Firebase", description: "Something about Firebase", isOptIn: true, supportDeletion: true)
        let service2 = ServiceModel(id: "S2", name: "Crashlytics", description: "Something about Crashlytics", isOptIn: false, supportDeletion: false)
        GDPRManager.servicesList.append(service)
        GDPRManager.servicesList.append(service2)
        
    }
    
}
