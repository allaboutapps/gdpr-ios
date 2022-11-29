//
//  File.swift
//  
//
//  Created by Stefan Draskovits on 29.11.22.
//

import Foundation

extension Sequence where Element: Hashable {
    var hasDuplicates: Bool {
        var elements = Set<Element>()
        for element in self {
            guard !elements.contains(element) else { return true }
            elements.insert(element)
        }
        return false
    }
}
