import Foundation
import SwiftUI

public enum GDPRAppearance {
    public static var primaryColor: Color = .primary
    public static var navigationBarTintColor: Color = .accentColor
    public static var bodyColor: Color = .primary
    public static var disabledColor: Color = Color(white: 0.8)

    public static var headlineFont = Font.title3
    public static var bodyFont = Font.body
    public static var linkFont = Font.body
    public static var serviceBodyFont = Font.body
    public static var subheaderFont = Font.headline
    public static var controlsFont = Font.subheadline

    enum Padding {
        public static var single: CGFloat = 8
        public static var double: CGFloat = 16
    }
}
