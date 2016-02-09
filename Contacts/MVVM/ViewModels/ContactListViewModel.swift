//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Ion Brumari on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

protocol ContactListViewModelProtocol: class {
    
    func refreshContent()
    func getAllContactsCount() -> Int
    func cellModelAtIndex(index: Int) -> ContactCellViewModel
    func selectWithIndex(index: Int)
    func removeWithIndex(index: Int)
    
    var contactDetailViewModel: ContactDetailsViewModelProtocol? { get }
}

class ContactListViewModel: ContactListViewModelProtocol {
    
    var contactDetailViewModel: ContactDetailsViewModelProtocol?
    var allContacts = [ContactMVVM]()
    
    
    init() {
        refreshContent()
    }
    
    func refreshContent() {
        allContacts = ExternalConnector.sharedManager().persistentManager.getAllPersistentContacts() as! [ContactMVVM]
    }
    
    func getAllContactsCount() -> Int {
        return allContacts.count
    }
    
    
    func cellModelAtIndex(index: Int) -> ContactCellViewModel {
        return ContactCellViewModel(contact: allContacts[index])
    }
    
    
    func selectWithIndex(index: Int) {
        contactDetailViewModel?.selectContact(allContacts[index])
    }
    
    
    func removeWithIndex(index: Int) {
        let contact = allContacts[index]
        ExternalConnector.sharedManager().persistentManager.removePersistentObject(contact)
        refreshContent()
    }
}