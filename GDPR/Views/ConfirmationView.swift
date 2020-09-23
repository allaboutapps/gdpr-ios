//
//  ConfirmationView.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

public struct ConfirmationView: View {
    @State var isEnabled = false
    @Environment(\.presentationMode) var presentation
    var viewModel: ConfirmationViewModel?
    
    public init() {
        if #available(iOS 14.0, *) {
            
        } else {
            UITableView.appearance().tableFooterView = UIView()
        }
    }
    public var body: some View {
        VStack {
            List {
                VStack(alignment: .leading, spacing: 16) {
                    TermsItem(isToggle: $isEnabled)
                    PolicyItem(descritpion: viewModel?.itemDescription ?? "", linkTitle: viewModel?.itemLinkTitle ?? "", url: viewModel?.itemURL ?? "")
                }
            }
            Button(action: {
                self.viewModel?.savePolicy()
                self.presentation.wrappedValue.dismiss()
            }) {
                Text(Strings.confirm)
            }
            .padding(EdgeInsets(top: 8, leading: 50, bottom: 8, trailing: 50))
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .accentColor(.white)
            .disabled(!isEnabled)
            
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
