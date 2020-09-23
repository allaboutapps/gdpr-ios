//
//  PersistenceManager.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    public static var shared = PersistenceManager()
    
    private let url = FileManager().urls(for: .documentDirectory,
                                         in: .userDomainMask).first!.appendingPathComponent("gdpr.json")
    public func saveStatus(status: Status) {
        DispatchQueue.global().sync {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try encoder.encode(status)
                try data.write(to: url)
            } catch {
                print("\(error)")
            }
        }
    }
    
    public func retrieveStatus() -> Status? {
        guard FileManager().fileExists(atPath: url.relativePath) else {
            return Status(lastAcceptedPrivacy: .undefined)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let currenStatus = try JSONDecoder().decode(Status.self, from: data)
             return currenStatus
        } catch {
            return nil
        }
    }
}
