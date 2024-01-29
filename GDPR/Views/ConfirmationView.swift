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
        isEnabled = !viewModel.showTermsOfService
    }

    public var body: some View {
        ZStack {
            GDPRAppearance.backgoundColor
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: GDPRAppearance.Padding.double) {
                        if viewModel.showTermsOfService {
                            TermsItem(isToggle: $isEnabled, termsURL: viewModel.termsURL, showSwitch: viewModel.showTermsSwitch)
                        }
                        if viewModel.showPrivacyPolicy {
                            PolicyItem(url: viewModel.policyURL)
                        }
                        if !viewModel.servicesList.isEmpty {
                            TrackingItem(acceptAll: $viewModel.acceptAll, url: viewModel.policyURL)
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
                            .padding(EdgeInsets(top: 8, leading: 100, bottom: 8, trailing: 100))
                            .background(isEnabled ? GDPRAppearance.primaryColor : GDPRAppearance.disabledColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .accentColor(.white)
                    })
                    .disabled(!isEnabled)
                }
            }
        }
        .navigationBarTitle(viewModel.title)
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(viewModel: ConfirmationViewModel(title: "", showTermsOfService: true, showPrivacyPolicy: true, showSettings: true, showSaveButton: true, policyURL: URL(string: "")!, termsURL: URL(string: "")!, services: nil, showTermsSwitch: true), onConfirm: nil)
    }
}
