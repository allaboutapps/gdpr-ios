//
//  GDPRManager.swift
//  GDPR
//
//  Created by Lyn Almasri on 18.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

public class GDPRManager {
    var termsURL: URL
    var privacyPolicyURL: URL
    var currentStatus: Status
    var confirmationViewModel: ConfirmationViewModel?
    
    public static var delegate: GDPRDelegate?
    
    public init(termsURL: URL, privacyPolicyURL: URL) {
        self.currentStatus = PersistenceManager.shared.retrieveStatus()
        self.termsURL = termsURL
        self.privacyPolicyURL = privacyPolicyURL
    }
    
    public func setService(id: String, name: String, description: String, supportDeletion: Bool) {
        for service in currentStatus.services where id == service.id {
            service.description = description
            service.name = name
            service.supportDeletion = supportDeletion
            return
        }
        currentStatus.services.append(ServiceModel(id: id, name: name, description: description, supportDeletion: supportDeletion, isOptIn: false))
        PersistenceManager.shared.saveStatus(status: currentStatus)
    }
    
    public func deleteService(id: String) {
        currentStatus.services = currentStatus.services.filter { $0.id != id }
        
        PersistenceManager.shared.saveStatus(status: currentStatus)
    }
    
    // function to view tos with (requireTOS, showSettings)
    public func presentConformationForm(showTermsOfService: Bool, showSettings: Bool) -> ConfirmationView {
        var title: String
        var shouldTermsOfService: Bool
        var showPrivacyPolicy: Bool
     
        if showTermsOfService {
//            title = Strings.termsTitle
            title = NSLocalizedString("termsTitle", comment: "")
            shouldTermsOfService = true
            if !showSettings {
                showPrivacyPolicy = true
            } else {
                showPrivacyPolicy = false
            }
            
        } else {
            title = NSLocalizedString("trackingSettingsHeader", comment: "")
            shouldTermsOfService = false
            showPrivacyPolicy = false
        }
        confirmationViewModel = ConfirmationViewModel(title: title,
                                                      showTermsOfService: shouldTermsOfService,
                                                      showPrivacyPolicy: showPrivacyPolicy,
                                                      showSettings: showSettings,
                                                      showSaveButton: true,
                                                      policyURL: privacyPolicyURL,
                                                      termsURL: termsURL,
                                                      services: currentStatus.services)
        return ConfirmationView(viewModel: confirmationViewModel!)
    }
    
    public func presentSettings(showTOS: Bool = false) -> ConfirmationView {
        confirmationViewModel = ConfirmationViewModel(title: NSLocalizedString("trackingSettingsHeader", comment: ""),
                                                      showTermsOfService: showTOS, showPrivacyPolicy: false,
                                                      showSettings: true,
                                                      showSaveButton: false,
                                                      policyURL: privacyPolicyURL,
                                                      termsURL: termsURL,
                                                      services: currentStatus.services)
        return ConfirmationView(viewModel: confirmationViewModel!)
    }
    
    public func shouldPresentTOS() -> Bool {
        let latestPolicyChange = Date() // need to get this from the server
        let currentStatus = PersistenceManager.shared.retrieveStatus()
        
        let shouldPresent: Bool
        switch currentStatus.lastAcceptedPrivacy {
        case .accepted(let at):
            shouldPresent = at < latestPolicyChange
        case .rejected:
            shouldPresent = true
        case .undefined:
            shouldPresent = false
        }
        return shouldPresent
    }
}
