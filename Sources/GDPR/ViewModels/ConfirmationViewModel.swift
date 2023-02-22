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
    var showTermsSwitch: Bool

    var servicesList = [ServiceModel]()
    @Published var acceptAll = false {
        didSet {
            for service in servicesList {
                service.isOptIn = true
            }
        }
    }

    init(title: String, showTermsOfService: Bool, showPrivacyPolicy: Bool, showSettings: Bool, showSaveButton: Bool, policyURL: URL, termsURL: URL, services: [ServiceModel]?, showTermsSwitch: Bool) {
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
        self.showTermsSwitch = showTermsSwitch
    }

    func savePolicy(date: Date = Date()) {
        let persistenceManager = PersistenceManager()
        persistenceManager.saveStatus(status: Status(latestPolicyChange: GDPRManager.shared.currentStatus?.latestPolicyChange, lastAcceptedPrivacy: .accepted(at: date), services: servicesList))
    }
}
