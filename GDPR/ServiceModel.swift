//
//  ServiceModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 23.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

public class ServiceModel {
    var id: String?
    var name: String?
    var description: String?
    var isOptIn: Bool?
    var supportDeletion: Bool?
    
    init(id: String, name: String, description: String?, isOptIn: Bool = false, supportDeletion: Bool?) {
        self.id = id
        self.name = name
        self.description = description
        self.isOptIn = isOptIn
        self.supportDeletion = supportDeletion
    }
    
    public var optOut: (()->Void)?
    public var deleteData: (()->Void)?
}
