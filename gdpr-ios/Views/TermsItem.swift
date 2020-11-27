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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.termsTitle)
                .font(GDPRAppearance.headline)
            Text(Strings.termsDescription)
                .font(GDPRAppearance.body)
            Button(action: {
                self.showWebView.toggle()

            }, label: {
                Text(Strings.termsTitle)
            }).sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: termsURL)
                        .navigationBarTitle(Text(Strings.termsTitle), displayMode: .inline)
                }
            }
            .foregroundColor(GDPRAppearance.primaryColor)
            .font(GDPRAppearance.callout)
            Toggle(isOn: $isToggle) {
                Text(Strings.termsAcceptance)
                    .font(GDPRAppearance.subheader)
            }

        }.buttonStyle(PlainButtonStyle())
    }
}

struct TermsItem_Previews: PreviewProvider {
    static var previews: some View {
        TermsItem(isToggle: .constant(false), termsURL: URL(string: "")!)
    }
}