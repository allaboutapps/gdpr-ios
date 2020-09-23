//
//  ConfirmationViewModel.swift
//  GDPR
//
//  Created by Lyn Almasri on 22.09.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import Foundation

class ConfirmationViewModel {

    var itemDescription: String?
    var itemLinkTitle: String?
    var itemURL: String?
    var showSettings: Bool?
    
    init(itemDescription: String?, itemLinkTitle: String?, itemURL: String?) {
        self.itemDescription = itemDescription
        self.itemLinkTitle = itemLinkTitle
        self.itemURL = itemURL
    }
    
    func confirmationView(showSettings: Bool) -> ConfirmationView {
        var confirmationView = ConfirmationView()
        confirmationView.viewModel = self
        return confirmationView
    }
    func savePolicy() {
        let persistenceManager = PersistenceManager()
        persistenceManager.saveStatus(status: Status(lastAcceptedPrivacy: .accepted(at: Date())))
    }
}
