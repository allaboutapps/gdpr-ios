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
    var url: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.trackingHeader)
                .font(.headline)
            Text(Strings.trackingDescription)
                .font(.body)
            HStack(alignment: .center, spacing: 8) {
                Button(action: {
                    self.showWebView.toggle()
                    
                }) {
                    Text(Strings.privacyTitle)
                }.sheet(isPresented: self.$showWebView) {
                    NavigationView {
                        ServiceWebView(url: URL(string: self.url))
                            .navigationBarTitle(Text(Strings.privacyTitle), displayMode: .inline)
                    }
                    
                }
                .foregroundColor(.orange)
                .font(.callout)
                Spacer()
                Button(action: {
                    self.acceptAll = true
                }) {
                    Text(Strings.allowAll)
                        .font(.subheadline)
                }.buttonStyle(PlainButtonStyle())
            }
            
        }.buttonStyle(PlainButtonStyle())
    }
}

struct TrackingItem_Previews: PreviewProvider {
    static var previews: some View {
        TrackingItem(acceptAll: .constant(false), url: "")
    }
}
