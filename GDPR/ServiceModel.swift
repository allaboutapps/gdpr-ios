//
//  ServiceModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 23.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

class ServiceModel: Codable, ObservableObject {
    var id: String
    var name: String
    var description: String
    @Published var isOptIn: Bool {
        didSet {
            GDPRManager.delegate?.valueDidChange(id: id, value: isOptIn)
        }
    }

    var supportDeletion: Bool?

    init(id: String, name: String, description: String, supportDeletion: Bool = false, isOptIn: Bool) {
        self.id = id
        self.name = name
        self.isOptIn = isOptIn
        self.supportDeletion = supportDeletion
        self.description = description
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isOptIn = try container.decode(Bool.self, forKey: .isOptIn)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.name = try container.decode(String.self, forKey: .name)
        self.supportDeletion = try container.decode(Bool.self, forKey: .supportDeletion)
    }

    enum CodingKeys: CodingKey {
        case isOptIn
        case id
        case name
        case description
        case supportDeletion
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isOptIn, forKey: .isOptIn)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(supportDeletion, forKey: .supportDeletion)
    }
    
    func delete() {
        GDPRManager.delegate?.deleteDate(id: self.id)
    }
}
