//
//  PolicyItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct PolicyItem: View {
    @State private var showWebView: Bool = false
    var url: URL

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.privacyDescription)
                .font(.body)
            Button(action: {
                self.showWebView.toggle()

            }, label: {
                Text(Strings.privacyTitle)
            }).sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: url)
                        .navigationBarTitle(Text(Strings.privacyTitle), displayMode: .inline)
                }
            }
            .foregroundColor(.orange)
            .font(.callout)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct PolicyItem_Previews: PreviewProvider {
    static var previews: some View {
        PolicyItem(url: URL(string: "")!)
    }
}
