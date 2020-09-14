//
//  PolicyItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct PolicyItem: View {
    var model: PolicyModel?
    @State private var isToggle: Bool = false
    @State private var showWebView: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model?.title ?? "Title")
                .font(.headline)
            Text(model?.details ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquipcillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .font(.body)
            Button(action: {
                self.showWebView.toggle()
                
            }) {
                Text(model?.linkTitle ?? "Link")
            }.sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: URL(string: ""))
                        .navigationBarTitle("Privacy Policy", displayMode: .inline)
                }
                
            }
            .foregroundColor(.orange)
            .font(.callout)
            if model?.agreement ?? true {
                Toggle(isOn: $isToggle) {
                    Text("Something to agree to")
                        .font(.subheadline)
                }
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

struct PolicyItem_Previews: PreviewProvider {
    static var previews: some View {
        PolicyItem()
    }
}
