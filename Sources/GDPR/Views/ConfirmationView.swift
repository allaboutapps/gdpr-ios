import SwiftUI

public struct ConfirmationView: View {
    @State
    private var isEnabled: Bool
    @ObservedObject var viewModel: ConfirmationViewModel

    var onConfirm: (() -> Void)?

    init(viewModel: ConfirmationViewModel, onConfirm: (() -> Void)?) {
        self.viewModel = viewModel
        self.onConfirm = onConfirm

        // If terms of service is not displayed enable complete button immediately
        isEnabled = !viewModel.showTermsSwitch
    }

    public var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: GDPRAppearance.Padding.double) {
                        if let termsURL = viewModel.termsURL {
                            TermsItem(isToggle: $isEnabled, termsURL: termsURL, showSwitch: viewModel.showTermsSwitch)
                        }
                        if let policyURL = viewModel.policyURL {
                            PolicyItem(url: policyURL)
                        }
                        if !viewModel.servicesList.isEmpty {
                            TrackingItem(acceptAll: $viewModel.acceptAll)
                        }
                    }

                    if viewModel.showSettings {
                        ForEach(0 ..< viewModel.servicesList.count, id: \.self) { index in
                            ServiceItem(model: viewModel.servicesList[index])
                        }
                    }
                }.padding(8)

                if viewModel.showSaveButton {
                    Button(action: {
                        self.viewModel.savePolicy()
                        self.onConfirm?()
                    }, label: {
                        Text("confirm", bundle: Bundle.module)
                    })
                    .disabled(!isEnabled)
                    .padding(.bottom, 10.0)
                    .buttonStyle(GDPRButtonStyle(config: GDPRAppearance.primaryButtonConfig))
                }
            }
        }
        .navigationBarTitle(viewModel.title)
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(viewModel: ConfirmationViewModel(title: "", showSettings: true, showSaveButton: true, policyURL: URL(string: "http://allaboutapps.at")!, termsURL: URL(string: "http://allaboutapps.at")!, services: nil, showTermsSwitch: true), onConfirm: nil)
    }
}
