import SwiftUI
import GDPR

class ViewController: UIViewController {
    let manager = GDPRManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Example App"

        print(FileManager().urls(for: .documentDirectory,
                                 in: .userDomainMask).first!.appendingPathComponent("gdpr.json"))
    }

    // Show settings without confirmation button
    @IBAction func showSettings(_: Any) {
        let hostingView = UIHostingController(rootView: manager.settingsView(title: "Legal Settings"))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    // Show Setting with confirmation button
    @IBAction func showForm(_: Any) {
        let hostingView = UIHostingController(rootView: manager.confirmationView(title: "Legal Settings", onConfirm: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            print("Confirmed!")
        }))
        navigationController?.pushViewController(hostingView, animated: true)
    }

    @IBAction func privacyChangedAlarm(_: Any) {
        manager.updateLatestPolicyTimestamp(date: Date())
        if manager.shouldPresentTOS() {
            let alert = manager.showAlert(title: "Legal Settings") { [weak self] view in
                let hostingView = UIHostingController(rootView: view)
                self?.navigationController?.pushViewController(hostingView, animated: true)
            }
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func acceptTerms(_: Any) {
        manager.acceptTermsAndPolicy()
    }
}
