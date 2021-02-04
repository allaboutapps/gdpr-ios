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
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.single) {
            Toggle(isOn: $model.isOptIn) {
                Text(model.name)
                    .font(GDPRAppearance.subheaderFont)
            }
            Text(model.description)
                .font(GDPRAppearance.bodyFont)
                .multilineTextAlignment(.leading)
            if model.supportDeletion ?? true {
                HStack {
                    Spacer()
                    Button(action: {
                        self.model.delete()
                    }, label: {
                        Text("deleteData",bundle: Bundle.module)
                            .font(GDPRAppearance.controlsFont)
                            .foregroundColor(GDPRAppearance.controlColor)
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
