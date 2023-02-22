import Foundation
import SwiftUI

public enum GDPRAppearance {
    public static var primaryColor: Color = .init(red: 175 / 255, green: 82 / 255, blue: 222 / 255)
    public static var navigationBarTintColor: Color = .blue
    public static var bodyColor: Color = .init(red: 79 / 255, green: 79 / 255, blue: 79 / 255)
    public static var disabledColor: Color = .init(red: 180 / 255, green: 180 / 255, blue: 180 / 255)

    public static var headlineFont = Font.system(size: 17.0).bold()
    public static var bodyFont = Font.system(size: 17)
    public static var linkFont = Font.system(size: 17)
    public static var serviceBodyFont = Font.system(size: 15)
    public static var subheaderFont = Font.system(size: 17)
    public static var controlsFont = Font.system(size: 15)

    public static var backgoundColor = Color.gray

    enum Padding {
        public static var single: CGFloat = 8
        public static var double: CGFloat = 16
    }
}
