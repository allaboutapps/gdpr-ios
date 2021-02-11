//
//  PolicyItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

public struct PolicyItem: View {
    @State private var showWebView: Bool = false
    var url: URL

    public var body: some View {
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.single) {
            Text("privacyTitle")
                .font(GDPRAppearance.headlineFont,bundle: Bundle.module)
            
            Text("privacyDescription")
                .fixedSize(horizontal: false, vertical: true)
                .font(GDPRAppearance.bodyFont)
                .foregroundColor(GDPRAppearance.bodyColor)
            
            Button(action: {
                self.showWebView.toggle()

            }, label: {
                Text("privacyTitle",bundle: Bundle.module)
            }).sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: url)
                        .navigationBarTitle(Text("privacyTitle",bundle: Bundle.module), displayMode: .inline)
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
            
            Divider()
        }.buttonStyle(PlainButtonStyle())
    }
}

struct PolicyItem_Previews: PreviewProvider {
    static var previews: some View {
        PolicyItem(url: URL(string: "")!)
    }
}
