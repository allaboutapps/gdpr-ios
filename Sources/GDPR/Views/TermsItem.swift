import SwiftUI

struct TermsItem: View {
    @Binding public var isToggle: Bool
    @State private var showWebView: Bool = false

    var termsURL: URL
    var showSwitch: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.double) {
            VStack(alignment: .leading, spacing: GDPRAppearance.Padding.double) {
                Text("termsTitle", bundle: Bundle.module)
                    .font(GDPRAppearance.headlineFont)

                Text("termsDescription", bundle: Bundle.module)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(GDPRAppearance.bodyFont)
                    .foregroundColor(GDPRAppearance.bodyColor)

                Button(action: {
                    self.showWebView.toggle()

                }, label: {
                    Text("termsTitle", bundle: Bundle.module)
                }).sheet(isPresented: self.$showWebView) {
                    NavigationView {
                        ServiceWebView(url: termsURL)
                            .navigationBarTitle(Text("termsTitle", bundle: Bundle.module), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                self.showWebView.toggle()
                            }, label: {
                                Text("cancelButton", bundle: Bundle.module)
                            }))
                    }
                    .foregroundColor(GDPRAppearance.navigationBarTintColor)
                }
                .foregroundColor(GDPRAppearance.primaryColor)
                .font(GDPRAppearance.linkFont)
            }

            if showSwitch {
                Divider()
                if #available(iOS 14.0, *) {
                    Toggle(isOn: $isToggle) {
                        Text("termsAcceptance", bundle: Bundle.module)
                            .font(GDPRAppearance.bodyFont)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: GDPRAppearance.primaryColor))
                } else {
                    Toggle(isOn: $isToggle) {
                        Text("termsAcceptance", bundle: Bundle.module)
                            .font(GDPRAppearance.bodyFont)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            Divider()

        }.buttonStyle(PlainButtonStyle())
    }
}

struct TermsItem_Previews: PreviewProvider {
    static var previews: some View {
        TermsItem(isToggle: .constant(false), termsURL: URL(string: "")!, showSwitch: true)
    }
}
