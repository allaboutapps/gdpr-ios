//
//  ServiceModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 23.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

public class ServiceModel: ObservableObject {

    var id: String?
    var name: String?
    var description: String?
    @Published var isOptIn = false {
        didSet {
            print(isOptIn)
        }
    }
    var supportDeletion: Bool?
    
    public init(id: String = "", name: String = "", description: String? = "", isOptIn: Bool = false, supportDeletion: Bool? = false) {
        self.id = id
        self.name = name
        self.description = description
        self.isOptIn = isOptIn
        self.supportDeletion = supportDeletion
    }
    
}
