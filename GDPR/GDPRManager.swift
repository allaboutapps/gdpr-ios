//
//  GDPRManager.swift
//  GDPR
//
//  Created by Lyn Almasri on 18.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

public class GDPRManager {
    var termsURL: URL?
    var privacyPolicyURL: URL?
    var currentStatus: Status?
    var confirmationViewModel: ConfirmationViewModel?
    
    public weak var delegate: GDPRDelegate?
    public static var shared = GDPRManager()
    
    public func setURLs(termsURL: URL, privacyPolicyURL: URL) {
        currentStatus = PersistenceManager.shared.retrieveStatus()
        self.termsURL = termsURL
        self.privacyPolicyURL = privacyPolicyURL
    }
    
    public func setService(id: String, name: String, description: String, supportDeletion: Bool) {
        guard let currentStatus = currentStatus else { return }
        for service in currentStatus.services where id == service.id {
            service.description = description
            service.name = name
            service.supportDeletion = supportDeletion
            return
        }
        self.currentStatus?.services.append(ServiceModel(id: id, name: name, description: description, supportDeletion: supportDeletion, isOptIn: false))
        PersistenceManager.shared.saveStatus(status: currentStatus)
    }
    
    public func updateLatestPolicyTimestamp(date: Date) {
        if currentStatus == nil {
            return
        }
        currentStatus!.latestPolicyChange = date
        PersistenceManager.shared.saveStatus(status: currentStatus!)
    }
    
    public func deleteService(id: String) {
        if currentStatus == nil {
            return
        }
        currentStatus!.services = currentStatus!.services.filter { $0.id != id }
        
        PersistenceManager.shared.saveStatus(status: currentStatus!)
    }
    
    // function to view tos with (requireTOS, showSettings)
    public func presentConformationForm(showTermsOfService: Bool, showSettings: Bool) -> ConfirmationView? {
        var title: String
        var shouldTermsOfService: Bool
        var showPrivacyPolicy: Bool
     
        if showTermsOfService {
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
        guard let termsURL = termsURL, let policyURL = privacyPolicyURL, let currentStatus = currentStatus else {
            print("Missing terms URL or policy URL")
            return nil
        }
        confirmationViewModel = ConfirmationViewModel(title: title,
                                                      showTermsOfService: shouldTermsOfService,
                                                      showPrivacyPolicy: showPrivacyPolicy,
                                                      showSettings: showSettings,
                                                      showSaveButton: true,
                                                      policyURL: policyURL,
                                                      termsURL: termsURL,
                                                      services: currentStatus.services)
        return ConfirmationView(viewModel: confirmationViewModel!)
    }
    
    public func presentSettings(showTOS: Bool = false) -> ConfirmationView? {
        guard let termsURL = termsURL, let policyURL = privacyPolicyURL, let currentStatus = currentStatus else {
            print("Missing terms URL or policy URL")
            return nil
        }
        confirmationViewModel = ConfirmationViewModel(title: NSLocalizedString("trackingSettingsHeader", comment: ""),
                                                      showTermsOfService: showTOS, showPrivacyPolicy: false,
                                                      showSettings: true,
                                                      showSaveButton: false,
                                                      policyURL: policyURL,
                                                      termsURL: termsURL,
                                                      services: currentStatus.services)
        return ConfirmationView(viewModel: confirmationViewModel!)
    }
    
    public func shouldPresentTOS() -> Bool {
        
        let currentStatus = PersistenceManager.shared.retrieveStatus()
        let latestPolicyChange = currentStatus.latestPolicyChange
        
        let shouldPresent: Bool
        switch currentStatus.lastAcceptedPrivacy {
        case .accepted(let at):
            shouldPresent = at < latestPolicyChange ?? Date()
        case .rejected:
            shouldPresent = true
        case .undefined:
            shouldPresent = false
        }
        return shouldPresent
    }
}
