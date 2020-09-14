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
        let hostingView = UIHostingController(rootView: manager.presentTos())
        navigationController?.pushViewController(hostingView, animated: true)
    }
}
