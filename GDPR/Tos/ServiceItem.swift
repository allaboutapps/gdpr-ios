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
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $toggable) {
                Text("Service Title")
                    .font(.body)
            }
            Text("details to show about the service")
                .font(.subheadline)
        }
    }
}

struct ServiceItem_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItem()
    }
}
