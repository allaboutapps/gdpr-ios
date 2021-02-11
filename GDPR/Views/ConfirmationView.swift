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
    @ObservedObject var viewModel: ConfirmationViewModel
    
    init(viewModel: ConfirmationViewModel) {
        if #available(iOS 14.0, *) {
        } else {
            UITableView.appearance().tableFooterView = UIView()
        }
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            List {
                VStack(alignment: .leading, spacing: 50) {
                    if viewModel.showTermsOfService {
                        TermsItem(isToggle: $isEnabled, termsURL: viewModel.termsURL, showSwitch: viewModel.showTermsSwitch)
                    }
                    if viewModel.showPrivacyPolicy {
                        PolicyItem(url: viewModel.policyURL)
                    }
                    if viewModel.showSettings {
                        TrackingItem(acceptAll: $viewModel.acceptAll, url: viewModel.policyURL)
                    }
                }
                
                if viewModel.showSettings {
                    ForEach(0 ..< viewModel.servicesList.count, id: \.self) { index in
                        ServiceItem(model: viewModel.servicesList[index])
                    }
                }
            }
            
            if viewModel.showSaveButton {
                Button(action: {
                    self.viewModel.savePolicy()
                    self.presentation.wrappedValue.dismiss()
                }, label: {
//                    Text("confirm",bundle: Bundle.module)
                    Text("confirm")
                })
                .padding(EdgeInsets(top: 8, leading: 50, bottom: 8, trailing: 50))
                .background(GDPRAppearance.primaryColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accentColor(.white)
                .disabled(!isEnabled)
            }
        }
        .navigationBarTitle(viewModel.title, displayMode: .large )
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(viewModel: ConfirmationViewModel(title: "", showTermsOfService: true, showPrivacyPolicy: true, showSettings: true, showSaveButton: true, policyURL: URL(string: "")!, termsURL: URL(string: "")!, services: nil, showTermsSwitch: true))
    }
}
