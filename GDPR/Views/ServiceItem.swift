//
//  ServiceItem.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import SwiftUI

struct ServiceItem: View {
    @State var toggable: Bool = false
    var model: ServiceModel?
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $toggable) {
                Text(model?.name ?? "")
                    .font(.body)
            }
            Text(model?.description ?? "")
                .font(.subheadline)
            if model?.supportDeletion ?? false{
                HStack {
                    Spacer()
                    Button(action: {
                        self.model?.deleteData?()
                    }) {
                        Text(Strings.deleteData)
                    }
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
