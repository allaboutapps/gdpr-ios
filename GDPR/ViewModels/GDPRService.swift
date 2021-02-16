//
//  GDPRService.swift
//  GDPR
//
//  Created by Lyn Almasri on 15.02.21.
//  Copyright © 2021 All About Apps. All rights reserved.
//

import Foundation

public struct GDPRService {
    var id: String
    var name: String
    var description: String
    var supportDeletion: Bool?
    
    public init(id: String, name: String, description: String, supportDeletion: Bool = false) {
         self.id = id
         self.name = name
         self.supportDeletion = supportDeletion
         self.description = description
     }
}
