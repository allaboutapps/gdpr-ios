//
//  ServiceItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct ServiceItem: View {
    @ObservedObject var model = ServiceModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: $model.isOptIn ) {
                Text(model.name ?? "")
                    .font(.body)
            }
            Text(model.description ?? "")
                .font(.subheadline)
            if model.supportDeletion ?? true{
                HStack {
                    Spacer()
                    Button(action: {
//                        self.model?.deleteData?() find a different way
                    }) {
                        Text(Strings.deleteData)
                            .font(.subheadline)
                    }.buttonStyle(PlainButtonStyle())
                }

            }
            
        }
    }
}


struct ServiceItem_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItem()
    }
}
