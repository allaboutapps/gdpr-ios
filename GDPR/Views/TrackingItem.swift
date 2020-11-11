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
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.trackingHeader)
                .font(GDPRAppearance.headline)
            Text(Strings.trackingDescription)
                .font(GDPRAppearance.body)
            HStack(alignment: .center, spacing: 8) {
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
                .foregroundColor(GDPRAppearance.primaryColor)
                .font(GDPRAppearance.callout)
                Spacer()
                Button(action: {
                    self.acceptAll = true
                }, label: {
                    Text(Strings.allowAll)
                        .font(GDPRAppearance.subheader)
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
