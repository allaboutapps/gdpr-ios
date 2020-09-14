//
//  TosViewModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 19.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

class TosViewModel {
    var services: [PolicyModel]?
    
    init(services: [PolicyModel]) {
        self.services = services
    }
}
