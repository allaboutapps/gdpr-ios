//
//  TrackingItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 30.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct TrackingItem: View {
    @State private var showWebView: Bool = false
    @Binding var acceptAll: Bool
    var url: URL
    
    var body: some View {
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.single) {
//            Text("trackingHeader",bundle: Bundle.module)
            Text("trackingHeader")
                .font(GDPRAppearance.headlineFont)
//            Text("trackingDescription",bundle: Bundle.module)
            Text("trackingDescription")
                .font(GDPRAppearance.bodyFont)
            HStack(alignment: .center, spacing: GDPRAppearance.Padding.single) {
                Button(action: {
                    self.showWebView.toggle()
                    
                }, label: {
//                    Text("privacyTitle",bundle: Bundle.module)
                    Text("privacyTitle")
                }).sheet(isPresented: self.$showWebView) {
                    NavigationView {
                        ServiceWebView(url: url)
//                            .navigationBarTitle(Text("privacyTitle",bundle: Bundle.module), displayMode: .inline)
                            .navigationBarTitle(Text("privacyTitle"), displayMode: .inline)
                    }
                }
                .foregroundColor(GDPRAppearance.primaryColor)
                .font(GDPRAppearance.linkFont)
                Spacer()
                Button(action: {
                    self.acceptAll = true
                }, label: {
//                    Text("allowAll",bundle: Bundle.module)
                    Text("allowAll")
                        .font(GDPRAppearance.controlsFont)
                        .foregroundColor(GDPRAppearance.controlColor)
                }).buttonStyle(PlainButtonStyle())
            }
            
        }.buttonStyle(PlainButtonStyle())
    }
}

struct TrackingItem_Previews: PreviewProvider {
    static var previews: some View {
        TrackingItem(acceptAll: .constant(false), url: URL(string: "")!)
    }
}
