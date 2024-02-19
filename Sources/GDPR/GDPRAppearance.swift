import Foundation
import SwiftUI

public enum GDPRAppearance {

    // MARK: Color

    public static var primaryColor: Color = .primary
    public static var navigationBarTintColor: Color = .accentColor
    public static var bodyColor: Color = .primary
    public static var disabledColor: Color = .init(white: 0.8)

    // MARK: Font

    public static var headlineFont = Font.title3
    public static var bodyFont = Font.body
    public static var linkFont = Font.body
    public static var serviceBodyFont = Font.body
    public static var subheaderFont = Font.headline
    public static var controlsFont = Font.subheadline

    // MARK: Buttons

    public static var primaryButtonConfig = GDPRButtonConfig(
        labelColor: .white,
        font: bodyFont,
        backgroundConfig: .init(
            color: primaryColor,
            disabledColor: disabledColor,
            padding: EdgeInsets(top: 8, leading: 100, bottom: 8, trailing: 100),
            cornerModus: .radius(10)
        )
    )

    public static var linkButtonConfig = GDPRButtonConfig(
        labelColor: primaryColor,
        font: linkFont,
        backgroundConfig: nil
    )

    public static var acceptAllButtonConfig = GDPRButtonConfig(
        labelColor: primaryColor,
        font: linkFont,
        backgroundConfig: nil
    )

    enum Padding {
        public static var single: CGFloat = 8
        public static var double: CGFloat = 16
    }
}
