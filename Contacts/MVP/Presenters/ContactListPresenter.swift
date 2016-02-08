//
//  ContactListPresentor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

protocol ContactListPresenterProtocol: class {
    init(view:ContactListViewProtocol)
    
    func refreshContent()
    func totalContactsNumber() -> Int
    func presentContact(index:Int)
    func contactAtIndex(index: Int) -> ContactMVP
    func removeContact(index: Int)
}

class ContactListPresenter: NSObject, ContactListPresenterProtocol {
    
    unowned let view:ContactListViewProtocol
    var allContacts:[ContactMVP]?
    
    required init(view:ContactListViewProtocol) {
        self.view = view
        super.init()

        refreshContent()
    }
    
    // MARK: ContactListPresenterProtocol
    
    func refreshContent() {
        allContacts = ExternalConnector.sharedManager().persistentManager.getAllPersistentContacts() as? [ContactMVP]
    }
    
    func totalContactsNumber() -> Int {
        return allContacts?.count ?? 0
    }
    
    func presentContact(index:Int) {
        if let contact = allContacts?[index] {
            view.updateCell(contact.nickname, phoneNumber: contact.phoneNumber, avatarURL: contact.avatarURL)
        }
    }
    
    func contactAtIndex(index: Int) -> ContactMVP {
        return allContacts![index]
    }
    
    func removeContact(index: Int) {
        if let contact = allContacts?[index] {
            ExternalConnector.sharedManager().persistentManager.removePersistentObject(contact)
            refreshContent()
        }
    }
    
}
