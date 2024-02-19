import Combine
import Foundation

class ConfirmationViewModel: ObservableObject {
    var title: String
    var showSettings: Bool
    var showSaveButton: Bool
    var policyURL: URL?
    var termsURL: URL?
    var showTermsSwitch: Bool

    var servicesList = [ServiceModel]()
    @Published var acceptAll = false {
        didSet {
            for service in servicesList {
                service.isOptIn = true
            }
        }
    }

    init(title: String, showSettings: Bool, showSaveButton: Bool, policyURL: URL?, termsURL: URL?, services: [ServiceModel]?, showTermsSwitch: Bool) {
        if let services = services {
            servicesList = services
        }
        self.title = title
        self.showSettings = showSettings
        self.showSaveButton = showSaveButton
        self.policyURL = policyURL
        self.termsURL = termsURL
        self.showTermsSwitch = showTermsSwitch
    }

    func savePolicy(date: Date = Date()) {
        let persistenceManager = PersistenceManager()
        persistenceManager.saveStatus(status: Status(latestPolicyChange: GDPRManager.shared.currentStatus?.latestPolicyChange, lastAcceptedPrivacy: .accepted(date: date), services: servicesList))
    }
}
