//
//  ConfirmationViewModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation
import Combine

class ConfirmationViewModel{
    
    var title: String?
    var requireTOS: Bool?
    var showSettings: Bool?
    var showSaveButton: Bool?
    var showPrivacyPolicy: Bool?
    var policyURL: String?
    var termsURL: String?
    
    func confirmationView(title: String, requireTOS: Bool, showPrivacyPolicy: Bool, showSettings: Bool, showSaveButton: Bool) -> ConfirmationView {
        var confirmationView = ConfirmationView()
        confirmationView.viewModel = self
        self.title = title
        self.requireTOS = requireTOS
        self.showSettings = showSettings
        self.showPrivacyPolicy = showPrivacyPolicy
        self.showSaveButton = showSaveButton
        return confirmationView
    }
    
    func savePolicy() {
        let persistenceManager = PersistenceManager()
        persistenceManager.saveStatus(status: Status(lastAcceptedPrivacy: .accepted(at: Date())))
    }
}
