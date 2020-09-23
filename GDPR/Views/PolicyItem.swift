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
    var descritpion: String
    var linkTitle: String
    var url: String
    var body: some View {
         VStack(alignment: .leading, spacing: 8) {
                   Text(descritpion)
                       .font(.body)
                   Button(action: {
                       self.showWebView.toggle()
                       
                   }) {
                    Text(linkTitle)
                   }.sheet(isPresented: self.$showWebView) {
                       NavigationView {
                        ServiceWebView(url: URL(string: self.url))
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
        PolicyItem(descritpion: "Test Desc", linkTitle: "Link", url: "" )
    }
}
