//
//  PolicyItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct TermsItem: View {
    @Binding public var isToggle: Bool
    @State private var showWebView: Bool = false

    var termsURL: URL
    var showSwitch: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.double) {
            VStack(alignment: .leading, spacing: GDPRAppearance.Padding.double) {
                Text("termsTitle",bundle: Bundle.module)
                    .font(GDPRAppearance.headlineFont)

                Text("termsDescription",bundle: Bundle.module)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(GDPRAppearance.bodyFont)
                    .foregroundColor(GDPRAppearance.bodyColor)

                Button(action: {
                    self.showWebView.toggle()

                }, label: {
                    Text("termsTitle",bundle: Bundle.module)
                }).sheet(isPresented: self.$showWebView) {
                    NavigationView {
                        ServiceWebView(url: termsURL)
                            .navigationBarTitle(Text("termsTitle",bundle: Bundle.module), displayMode: .inline)
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("cancelButton",bundle: Bundle.module) {
                                        self.showWebView.toggle()
                                    }
                                }
                            })
                    }
                }
                .foregroundColor(GDPRAppearance.primaryColor)
                .font(GDPRAppearance.linkFont)
            }

            if showSwitch {
                Divider()
                Toggle(isOn: $isToggle) {
                    // Text("termsAcceptance",bundle: Bundle.module)
                    Text("termsAcceptance")
                        .font(GDPRAppearance.bodyFont)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .toggleStyle(SwitchToggleStyle(tint: GDPRAppearance.primaryColor))
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
