//
//  ServiceItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct ServiceItem: View {
    @ObservedObject var model: ServiceModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: $model.isOptIn) {
                Text(model.name)
                    .font(GDPRAppearance.body)
            }
            Text(model.description)
                .font(GDPRAppearance.subheader)
            if model.supportDeletion ?? true {
                HStack {
                    Spacer()
                    Button(action: {
                        self.model.delete()
                    }, label: {
                        Text(Strings.deleteData)
                            .font(GDPRAppearance.subheader)
                    }).buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ServiceItem_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItem(model: ServiceModel(id: "id", name: "name", description: "desc", isOptIn: true))
    }
}
