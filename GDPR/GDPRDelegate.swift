//
//  GDPRDelegate.swift
//  GDPR
//
//  Created by Lyn Almasri on 20.10.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

protocol GDPRDelegate: AnyObject {
    func valueDidChange(id: String, value: Bool)
    func deleteDate(id: String)
}
