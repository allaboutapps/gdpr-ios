//
//  Appearance.swift
//  GDPR
//
//  Created by Lyn Almasri on 26.10.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation
import SwiftUI

public class GDPRAppearance {
    public static var primaryColor: Color = Color(red: 175/255, green: 82/255, blue: 222/255)
    public static var bodyColor: Color = Color(red: 79/255, green: 79/255, blue: 79/255)
    public static var disabledColor: Color = Color(red: 180/255, green: 180/255, blue: 180/255)
    
    public static var headlineFont = Font.system(size: 17.0).bold()
    public static var bodyFont = Font.system(size: 17)
    public static var linkFont = Font.system(size: 17)
    public static var serviceBodyFont = Font.system(size: 12)
    public static var subheaderFont = Font.system(size: 17)
    public static var controlsFont = Font.system(size: 15)
    
    struct Padding {
        public static var single: CGFloat = 8
        public static var double: CGFloat = 16
    }
}
