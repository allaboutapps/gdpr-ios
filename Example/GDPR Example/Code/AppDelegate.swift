import GDPR
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GDPRDelegate {
    func termsAndConditionsAccepted() {
        print("Terms accepted")
    }

    func serviceValueDidChange(serviceId: String, isEnabled: Bool) {
        print("service: \(serviceId) changed value to \(isEnabled)")
    }

    func deleteData(serviceId: String) {
        print("Data deleted: \(serviceId)")
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GDPRManager.shared.setURLs(
            termsURL: Bundle.main.url(forResource: "terms_of_service", withExtension: "html")!,
            privacyPolicyURL: Bundle.main.url(forResource: "privacy_policy", withExtension: "html")!
        )
        GDPRManager.shared.delegate = self

        GDPRManager.shared.setServices(services: [
            GDPRManager.Service(id: "S1", name: "Firebase", description: "Something about Firebase", supportDeletion: true),
            GDPRManager.Service(id: "S2", name: "Crashlytics", description: "Something about Crashlytics", supportDeletion: false),
        ])

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
