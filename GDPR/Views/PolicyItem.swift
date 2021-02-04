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
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.single) {
//            Text("privacyDescription",bundle: Bundle.module)
            Text("privacyDescription")
                .font(GDPRAppearance.bodyFont)
            Button(action: {
                self.showWebView.toggle()

            }, label: {
//                Text("privacyTitle",bundle: Bundle.module)
                Text("privacyTitle")
            }).sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: url)
//                        .navigationBarTitle(Text("privacyTitle",bundle: Bundle.module), displayMode: .inline)
                        .navigationBarTitle(Text("privacyTitle"), displayMode: .inline)
                }
            }
            .foregroundColor(GDPRAppearance.primaryColor)
            .font(GDPRAppearance.linkFont)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct PolicyItem_Previews: PreviewProvider {
    static var previews: some View {
        PolicyItem(url: URL(string: "")!)
    }
}
