import SwiftUI

struct ServiceItem: View {
    @ObservedObject var model: ServiceModel
    var body: some View {
        VStack(alignment: .leading, spacing: GDPRAppearance.Padding.single) {
            Toggle(isOn: $model.isOptIn) {
                Text(model.name)
                    .font(GDPRAppearance.subheaderFont)
            }
            .toggleStyle(SwitchToggleStyle(tint: GDPRAppearance.primaryColor))
            .padding(.trailing, 8)

            Text(model.description)
                .font(GDPRAppearance.serviceBodyFont)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(GDPRAppearance.bodyColor)

            if model.supportDeletion {
                HStack {
                    Spacer()
                    Button(action: {
                        self.model.delete()
                    }, label: {
                        Text("deleteData", bundle: Bundle.module)
                            .font(GDPRAppearance.controlsFont)
                            .foregroundColor(GDPRAppearance.primaryColor)
                    }).buttonStyle(PlainButtonStyle())
                }
            }
            Divider()
        }
    }
}

struct ServiceItem_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItem(model: ServiceModel(id: "id", name: "name", description: "desc", supportDeletion: true, isOptIn: true))
    }
}
