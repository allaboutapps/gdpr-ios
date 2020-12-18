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

    public static let headline = Font.system(size: 18.0)
    public static let body = Font.system(size: 15)
    public static let link = Font.system(size: 13)
    public static let subheader = Font.system(size: 17)
    public static let controls = Font.system(size: 15)
    
    public struct Padding {
        public static var single: CGFloat = 8
        public static var double: CGFloat = 16
    }
}
