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
    public static var termsURL: String?
    var currentStatus: Status
    var confirmationViewModel = ConfirmationViewModel()
    static var delegate: GDPRDelegate?
    
    private init() {
        self.currentStatus = PersistenceManager.shared.retrieveStatus()
    }
    
    public func setService(id: String, name: String, description: String, supportDeletion: Bool) {
        for service in currentStatus.services where id == service.id {
            return
        }
        
        currentStatus.services.append(ServiceModel(id: id, name: name, description: description, supportDeletion: supportDeletion, isOptIn: false))
        PersistenceManager.shared.saveStatus(status: currentStatus)
    }
    
    // function to view tos with (requireTOS, showSettings)
    public func presentConformationForm(requireTOS: Bool, showSettings: Bool) -> ConfirmationView {
        var title: String
        var tos: Bool
        var privacyPolicy: Bool
     
        if requireTOS {
            title = Strings.termsTitle
            tos = true
            if !showSettings {
                privacyPolicy = true
            } else {
                privacyPolicy = false
            }
            
        } else {
            title = Strings.trackingSettingsHeader
            tos = false
            privacyPolicy = false
        }
        return confirmationViewModel.confirmationView(title: title, requireTOS: tos, showPrivacyPolicy: privacyPolicy, showSettings: showSettings, showSaveButton: true)
    }
    
    public func presentSettings(showTOS: Bool = false) -> ConfirmationView {
        return confirmationViewModel.confirmationView(title: Strings.trackingSettingsHeader, requireTOS: showTOS, showPrivacyPolicy: false, showSettings: true, showSaveButton: false)
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
