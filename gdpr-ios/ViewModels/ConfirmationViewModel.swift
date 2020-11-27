//
//  ConfirmationViewModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Combine
import Foundation

class ConfirmationViewModel: ObservableObject {
    var title: String
    var showTermsOfService: Bool
    var showSettings: Bool
    var showSaveButton: Bool
    var showPrivacyPolicy: Bool
    var policyURL: URL
    var termsURL: URL
    
    var servicesList = [ServiceModel]()
    @Published var acceptAll = false {
        didSet {
            for service in servicesList {
                service.isOptIn = true
            }
        }
    }
    
    init(title: String, showTermsOfService: Bool, showPrivacyPolicy: Bool, showSettings: Bool, showSaveButton: Bool, policyURL: URL, termsURL: URL, services: [ServiceModel]?) {
        if let services = services {
            servicesList = services
        }
        self.title = title
        self.showTermsOfService = showTermsOfService
        self.showSettings = showSettings
        self.showPrivacyPolicy = showPrivacyPolicy
        self.showSaveButton = showSaveButton
        self.policyURL = policyURL
        self.termsURL = termsURL
    }
    
    func savePolicy() {
        let persistenceManager = PersistenceManager()
        persistenceManager.saveStatus(status: Status(lastAcceptedPrivacy: .accepted(at: Date()), services: servicesList))
    }
}
