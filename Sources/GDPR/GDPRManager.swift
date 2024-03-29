import Foundation
import SwiftUI
import UIKit

public protocol GDPRDelegate: AnyObject {
    func serviceValueDidChange(serviceId: String, isEnabled: Bool)
    func deleteData(serviceId: String)
    func termsAndConditionsAccepted()
}

public class GDPRManager {
    public struct Service {
        var id: String
        var name: String
        var description: String
        var supportDeletion: Bool
        /// when the services are populated the `defaultOptInValue` specifies whether the service is enabled or disabled
        let defaultOptInValue: Bool

        public init(id: String, name: String, description: String, supportDeletion: Bool, defaultOptInValue: Bool = false) {
            self.id = id
            self.name = name
            self.supportDeletion = supportDeletion
            self.description = description
            self.defaultOptInValue = defaultOptInValue
        }
    }

    var termsURL: URL?
    var privacyPolicyURL: URL?
    var currentStatus: Status?
    var confirmationViewModel: ConfirmationViewModel?

    public weak var delegate: GDPRDelegate?
    public static var shared = GDPRManager()

    // MARK: - Interface

    public func settingsView(title: String) -> ConfirmationView? {
        guard let currentStatus = currentStatus else {
            return nil
        }

        confirmationViewModel = ConfirmationViewModel(
            title: title,
            showSettings: true,
            showSaveButton: false,
            policyURL: privacyPolicyURL,
            termsURL: termsURL,
            services: currentStatus.services,
            showTermsSwitch: false
        )

        return ConfirmationView(viewModel: confirmationViewModel!, onConfirm: nil)
    }

    public func settingsViewController(title: String) -> UIViewController? {
        guard let view = settingsView(title: title) else { return nil }
        return UIHostingController(rootView: view)
    }

    public func confirmationView(title: String,  showTermsSwitch: Bool = true, showSaveButton: Bool = true, onConfirm: @escaping () -> Void) -> ConfirmationView? {
        guard let currentStatus = currentStatus else { return nil }

        confirmationViewModel = ConfirmationViewModel(
            title: title,
            showSettings: true,
            showSaveButton: showSaveButton,
            policyURL: privacyPolicyURL,
            termsURL: termsURL,
            services: currentStatus.services,
            showTermsSwitch: showTermsSwitch
        )

        return ConfirmationView(viewModel: confirmationViewModel!) { [weak self] in
            self?.currentStatus = PersistenceManager.shared.retrieveStatus()
            onConfirm()
        }
    }

    public func confirmationViewController(title: String, showTermsSwitch: Bool = true, showSaveButton: Bool = true, onConfirm: @escaping () -> Void) -> UIViewController? {
        guard let view = confirmationView(title: title, showTermsSwitch: showTermsSwitch, showSaveButton: showSaveButton, onConfirm: onConfirm) else { return nil }
        return UIHostingController(rootView: view)
    }

    // MARK: - Helper Functions

    public func setURLs(termsURL: URL?, privacyPolicyURL: URL?) {
        currentStatus = PersistenceManager.shared.retrieveStatus()
        self.termsURL = termsURL
        self.privacyPolicyURL = privacyPolicyURL
    }
    
    public func setServices(services: [Service]) {
        guard let currentStatus = currentStatus else { return }

        assert(!services.map { $0.id }.hasDuplicates, "The ids of the services have to be unique")

        for service in services {
            for singleService in currentStatus.services where service.id == singleService.id {
                singleService.description = service.description
                singleService.name = service.name
                singleService.supportDeletion = service.supportDeletion
                return
            }

            self.currentStatus?.services.append(ServiceModel(id: service.id, name: service.name, description: service.description, supportDeletion: service.supportDeletion, isOptIn: service.defaultOptInValue))
        }

        PersistenceManager.shared.saveStatus(status: currentStatus)
    }

    public func isServiceEnabled(serviceId: String) -> Bool? {
        guard let currentStatus = currentStatus else { return nil }
        return currentStatus
            .services
            .first { $0.id == serviceId }?
            .isOptIn
    }

    public func updateService(serviceId: String, isEnabled: Bool) {
        guard let serviceModel = currentStatus?.services.first(where: { $0.id == serviceId }) else { return }

        serviceModel.isOptIn = isEnabled
    }

    public var termState: TermState {
        return currentStatus?.lastAcceptedPrivacy ?? .undefined
    }

    public func fetchServiceStatus() -> [String: Bool]? {
        guard let currentStatus = currentStatus else { return nil }
        assert(!currentStatus.services.map { $0.id }.hasDuplicates, "The ids of the services have to be unique")
        let idsAndStatus = currentStatus
            .services
            .map { ($0.id, $0.isOptIn) }

        return Dictionary(uniqueKeysWithValues: idsAndStatus)
    }

    public func updateLatestPolicyTimestamp(date: Date) {
        guard let currentStatus = currentStatus else { return }

        var newStatus = currentStatus
        newStatus.latestPolicyChange = date

        self.currentStatus = newStatus
        PersistenceManager.shared.saveStatus(status: newStatus)
    }

    public func deleteService(id: String) {
        guard let currentStatus = currentStatus else { return }

        var newStatus = currentStatus
        newStatus.services = currentStatus.services.filter { $0.id != id }

        self.currentStatus = newStatus
        PersistenceManager.shared.saveStatus(status: newStatus)
    }

    public func shouldPresentTOS() -> Bool {
        let currentStatus = PersistenceManager.shared.retrieveStatus()
        let latestPolicyChange = currentStatus.latestPolicyChange

        let shouldPresent: Bool
        switch currentStatus.lastAcceptedPrivacy {
        case .accepted(let date):
            shouldPresent = date < (latestPolicyChange ?? Date.distantPast)
        case .rejected:
            shouldPresent = true
        case .undefined:
            shouldPresent = true
        }

        return shouldPresent
    }

    public func acceptTermsAndPolicy(date: Date = Date()) {
        guard let currentStatus = currentStatus else {
            return
        }

        if confirmationViewModel == nil {
            confirmationViewModel = ConfirmationViewModel(
                title: "title",
                showSettings: true,
                showSaveButton: true,
                policyURL: privacyPolicyURL,
                termsURL: termsURL,
                services: currentStatus.services,
                showTermsSwitch: true
            )
        }

        confirmationViewModel?.savePolicy(date: date)
        self.currentStatus = PersistenceManager.shared.retrieveStatus()
    }

    public func showAlert(title: String, showConfirmationView: @escaping ((ConfirmationView?) -> Void)) -> UIAlertController {
        let alert = UIAlertController(
            title: NSLocalizedString("alertViewTitle", bundle: Bundle.module, comment: ""),
            message: NSLocalizedString("alertViewDescritption", bundle: Bundle.module, comment: ""),
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: NSLocalizedString("alertViewFirstButton", bundle: Bundle.module, comment: ""), style: .default) { [weak self] _ in
            self?.confirmationViewModel?.savePolicy()
        })

        alert.addAction(UIAlertAction(title: NSLocalizedString("alertViewSecondButton", bundle: Bundle.module, comment: ""), style: .default) { [weak self] _ in
            let view = self?.settingsView(title: title)
            showConfirmationView(view)
        })

        return alert
    }
}
