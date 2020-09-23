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
    
    // function to view tos with (requireTOS, showSettings)
    public func presentTos() -> ConfirmationView {
        let confirmationViewModel = ConfirmationViewModel(itemDescription: Strings.privacyDescription, itemLinkTitle: Strings.privacyTitle, itemURL: "")
        return confirmationViewModel.confirmationView(showSettings: true)
        
    }
    
    public func shouldPresentTOS() -> Bool {
        var latestPolicyChange = Date() //need to get this from the server
        let persistenceManager = PersistenceManager()
        let currentStatus = persistenceManager.retrieveStatus()
        
        let shouldPresent: Bool
        switch currentStatus?.lastAcceptedPrivacy {
        case .accepted(let at):
            shouldPresent = at < latestPolicyChange
        case .rejected:
            shouldPresent = true
        case .undefined:
            shouldPresent = false
        case .none:
            return false
        }
        return shouldPresent
    }
}

