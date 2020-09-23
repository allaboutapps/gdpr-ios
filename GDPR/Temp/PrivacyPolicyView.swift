//
//  PrivacyPolicyView.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

public struct PrivacyPolicyView: View {
    public init() {
        if #available(iOS 14.0, *) {
       
        } else {
            UITableView.appearance().tableFooterView = UIView()
        }
    }
    
public var body: some View {
    List {
        ForEach (1...3, id: \.self) { _ in
            ServiceItem()
        }
        
        Button(action: {
            print("Hi")
        }) {
            Text("Save")
        }
    .padding(EdgeInsets(top: 8, leading: 50, bottom: 8, trailing: 50))
        .background(Color.orange)
    .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(.white)

    }
        
    .navigationBarTitle(Text("Privacy Policy"), displayMode: .inline)
    
}
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
