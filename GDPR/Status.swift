//
//  Status.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

struct Status: Codable {
    var lastAcceptedPrivacy: TermState
}

enum TermState: Codable {
    case accepted(at: Date)
    case rejected
    case undefined
    
    enum CodingKeys: String, CodingKey {
        case accepted
        case rejected
        case undefined
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(Date.self, forKey: .accepted) {
            self = .accepted(at: value)
        } else if  (try? values.decode(String.self, forKey: .rejected)) != nil {
            self = .rejected
        } else if (try? values.decode(String.self, forKey: .undefined)) != nil {
            self = .undefined
        } else {
            self = .undefined
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
               switch self {
               case .accepted(let at):
                   try container.encode(at, forKey: .accepted)
               case .rejected:
                   try container.encode("notAccepted", forKey: .rejected)
               case .undefined:
                   try container.encode("undefined", forKey: .undefined)
               }
    }
}
