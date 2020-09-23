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
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.termsTitle)
                .font(.headline)
            Text(Strings.termsDescription)
                .font(.body)
            Button(action: {
                self.showWebView.toggle()
                
            }) {
                Text(Strings.termsTitle)
            }.sheet(isPresented: self.$showWebView) {
                NavigationView {
                    ServiceWebView(url: URL(string: GDPRManager.termsURL ?? ""))
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
        StatefulPreviewWrapper(false) { TermsItem(isToggle: $0) }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    var body: some View {
        content($value)
    }
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
