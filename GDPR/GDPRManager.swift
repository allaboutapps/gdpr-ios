//
//  GDPRManager.swift
//  GDPR
//
//  Created by Lyn Almasri on 18.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

public class GDPRManager {
    public static var shared = GDPRManager()
    
    // function to view tos with (requireTOS, showSettings)
    public func presentTos() -> PrivacyPolicyView {
        let tosViewController = TosViewController()
        var services = [PolicyModel]()
        let service = PolicyModel()
        service.title = "Title"
        service.details = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquipcillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        service.agreement = true
        service.linkTitle = "Click me"
        services.append(service)
        let secondService = PolicyModel()
        secondService.title = "Title"
        secondService.details = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquipcillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        secondService.agreement = false
        services.append(secondService)
        tosViewController.viewModel = TosViewModel(services: services)
        PrivacyPolicyView()
        return PrivacyPolicyView()
//        return tosViewController
    }
}
