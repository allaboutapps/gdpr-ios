//
//  GDPRManager.swift
//  GDPR
//
//  Created by Lyn Almasri on 18.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation
import UIKit

public class GDPRManager {
    var termsURL: URL?
    var privacyPolicyURL: URL?
    var currentStatus: Status?
    var confirmationViewModel: ConfirmationViewModel?
    
    public weak var delegate: GDPRDelegate?
    public static var shared = GDPRManager()
    
    // MARK: - Use Cases
    
    public func showSettings() -> ConfirmationView? {
        let title = NSLocalizedString("termsTitle", comment: "")
     
        guard let termsURL = termsURL, let policyURL = privacyPolicyURL, let currentStatus = currentStatus else {
            print("Missing terms URL or policy URL")
            return nil
        }
        confirmationViewModel = ConfirmationViewModel(title: title,
                                                      showTermsOfService: true,
                                                      showPrivacyPolicy: true,
                                                      showSettings: true,
                                                      showSaveButton: false,
                                                      policyURL: policyURL,
                                                      termsURL: termsURL,
                                                      services: currentStatus.services,
                                                      showTermsSwitch: true)
        return ConfirmationView(viewModel: confirmationViewModel!)
    }
    
    public func showForm() -> ConfirmationView? {
        let title = NSLocalizedString("termsTitle", comment: "")
     
        guard let termsURL = termsURL, let policyURL = privacyPolicyURL, let currentStatus = currentStatus else {
            print("Missing terms URL or policy URL")
            return nil
        }
        confirmationViewModel = ConfirmationViewModel(title: title,
                                                      showTermsOfService: true,
                                                      showPrivacyPolicy: true,
                                                      showSettings: true,
                                                      showSaveButton: true,
                                                      policyURL: policyURL,
                                                      termsURL: termsURL,
                                                      services: currentStatus.services,
                                                      showTermsSwitch: true)
        return ConfirmationView(viewModel: confirmationViewModel!)
    }
    
    public func toggleView() -> ConfirmationToggleView {
        return ConfirmationToggleView()
    }
    
    // MARK: - Helper Functions
    
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
            shouldPresent = true
        }
        return shouldPresent
    }
    
    public func acceptTermsAndPolicy() {
        confirmationViewModel?.savePolicy()
    }
    
    public func showAlert(showConfirmationView: @escaping ((ConfirmationView?) -> Void)) -> UIAlertController {
        let alert = UIAlertController(title: "Our privacy policy has changed", message: "Please note that we updated both our privacy as well as our terms of use. Read through the changes and learn more about the rights. In order to continue using the app, please accept the updated privacy policy.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Read and understood", style: .default, handler: { [weak self] _ in
            self?.confirmationViewModel?.savePolicy()
        }))
        alert.addAction(UIAlertAction(title: "View privacy policy", style: .default, handler: { [weak self] _ in
            let view = self?.showSettings()
            showConfirmationView(view)
        }))
        return alert
    }
}
