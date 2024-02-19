import Foundation
import SwiftUI

public struct GDPRButtonConfig {

    let labelColor: Color
    let font: Font
    let backgroundConfig: BackgroundConfig?

    public init(labelColor: Color, font: Font, backgroundConfig: BackgroundConfig?) {
        self.labelColor = labelColor
        self.font = font
        self.backgroundConfig = backgroundConfig
    }

    public struct BackgroundConfig {

        let color: Color
        let disabledColor: Color
        let padding: EdgeInsets
        let cornerModus: CornerRadius

        public init(color: Color, disabledColor: Color, padding: EdgeInsets, cornerModus: CornerRadius = .radius(10)) {
            self.color = color
            self.disabledColor = disabledColor
            self.padding = padding
            self.cornerModus = cornerModus
        }

        public enum CornerRadius: ViewModifier {
            case radius(CGFloat)
            case round

            public func body(content: Content) -> some View {
                switch self {
                case .radius(let float):
                    content.clipShape(RoundedRectangle(cornerRadius: float))
                case .round:
                    content.clipShape(Capsule())
                }
            }
        }
    }
}

public struct GDPRButtonStyle: ButtonStyle {

    let config: GDPRButtonConfig

    @Environment(\.isEnabled)
    var isEnabled: Bool

    func backgroundColor(for configuration: Configuration, backgroundConfig: GDPRButtonConfig.BackgroundConfig) -> Color {
        if configuration.isPressed {
            backgroundConfig.color.opacity(0.7)
        } else if isEnabled {
            backgroundConfig.color
        } else {
            backgroundConfig.disabledColor
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        if let backgroundConfig = config.backgroundConfig {
            configuration.label
                .font(config.font)
                .foregroundStyle(config.labelColor)
                .padding(backgroundConfig.padding)
                .background(backgroundColor(for: configuration, backgroundConfig: backgroundConfig))
                .tint(backgroundConfig.color)
                .modifier(backgroundConfig.cornerModus)
        } else {
            configuration.label
                .font(config.font)
                .foregroundStyle(config.labelColor)
        }
    }
}
