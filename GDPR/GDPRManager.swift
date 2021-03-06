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
    public struct Service {
        var id: String
        var name: String
        var description: String
        var supportDeletion: Bool
        
        public init(id: String, name: String, description: String, supportDeletion: Bool) {
            self.id = id
            self.name = name
            self.supportDeletion = supportDeletion
            self.description = description
        }
    }
    
    var termsURL: URL?
    var privacyPolicyURL: URL?
    var currentStatus: Status?
    var confirmationViewModel: ConfirmationViewModel?
    
    public weak var delegate: GDPRDelegate?
    public static var shared = GDPRManager()
    
    // MARK: - Use Cases
    
    public func showSettings(title: String) -> ConfirmationView? {
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
                                                      showTermsSwitch: false)
        return ConfirmationView(viewModel: confirmationViewModel!, onConfirm: nil)
    }
    
    public func showForm(title: String, onConfirm: @escaping () -> Void) -> ConfirmationView? {
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
        return ConfirmationView(viewModel: confirmationViewModel!, onConfirm: onConfirm)
    }
    
    // MARK: - Helper Functions
    
    public func setURLs(termsURL: URL, privacyPolicyURL: URL) {
        currentStatus = PersistenceManager.shared.retrieveStatus()
        self.termsURL = termsURL
        self.privacyPolicyURL = privacyPolicyURL
    }
    
    public func setServices(services: [Service]) {
        guard let currentStatus = currentStatus else { return }
        for service in services {
            for singleService in currentStatus.services where service.id == singleService.id {
                singleService.description = service.description
                singleService.name = service.name
                singleService.supportDeletion = service.supportDeletion
                return
            }
            self.currentStatus?.services.append(ServiceModel(id: service.id, name: service.name, description: service.description, supportDeletion: service.supportDeletion, isOptIn: false))
        }
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
    
    public func acceptTermsAndPolicy(date: Date = Date()) {
        guard let termsURL = termsURL, let policyURL = privacyPolicyURL, let currentStatus = currentStatus else {
            print("Missing terms URL or policy URL")
            return
        }
        if confirmationViewModel == nil {
            confirmationViewModel = ConfirmationViewModel(title: "title",
                                                          showTermsOfService: true,
                                                          showPrivacyPolicy: true,
                                                          showSettings: true,
                                                          showSaveButton: true,
                                                          policyURL: policyURL,
                                                          termsURL: termsURL,
                                                          services: currentStatus.services,
                                                          showTermsSwitch: true)
        }
        confirmationViewModel?.savePolicy(date: date)
    }
    
    public func showAlert(title: String, showConfirmationView: @escaping ((ConfirmationView?) -> Void)) -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("alertViewTitle", bundle: Bundle.module, comment: ""),
                                      message: NSLocalizedString("alertViewDescritption", bundle: Bundle.module, comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("alertViewFirstButton", bundle: Bundle.module, comment: ""), style: .default, handler: { [weak self] _ in
            self?.confirmationViewModel?.savePolicy()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("alertViewSecondButton", bundle: Bundle.module, comment: ""), style: .default, handler: { [weak self] _ in
            let view = self?.showSettings(title: title)
            showConfirmationView(view)
        }))
        return alert
    }
}
