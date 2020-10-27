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

    var termsURL: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.termsTitle)
                .font(.headline)
            Text(Strings.termsDescription)
                .font(.body)
            Button(action: {
                self.showWebView.toggle()

            }, label: {
                Text(Strings.termsTitle)
            }).sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: URL(string: self.termsURL))
                        .navigationBarTitle(Text(Strings.termsTitle), displayMode: .inline)
                }
            }
            .foregroundColor(.orange)
            .font(.callout)
            Toggle(isOn: $isToggle) {
                Text(Strings.termsAcceptance)
                    .font(.subheadline)
            }

        }.buttonStyle(PlainButtonStyle())
    }
}

struct TermsItem_Previews: PreviewProvider {
    static var previews: some View {
        TermsItem(isToggle: .constant(false), termsURL: "")
    }
}
