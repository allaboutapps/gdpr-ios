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
    public static var primaryColor: Color = .orange
    public static var controlColor: Color = .gray
    
    public static var headlineFont = Font.system(size: 18.0)
    public static var bodyFont = Font.system(size: 15)
    public static var linkFont = Font.system(size: 13)
    public static var subheaderFont = Font.system(size: 17)
    public static var controlsFont = Font.system(size: 15)
    
    public struct Padding {
        public static var single: CGFloat = 8
        public static var double: CGFloat = 16
    }
}
