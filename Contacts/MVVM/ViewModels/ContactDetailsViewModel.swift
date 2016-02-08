//
//  ContactDetailsViewModel.swift
//  Contacts
//
//  Created by Ion Brumari on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol ContactDetailsViewModelProtocol: class {
    
    var contactName: MutableProperty<String?> { get }
    var contactPhone: MutableProperty<String?> { get }
    var contactAvatar: MutableProperty<String?> { get }
    
    func selectContact(contact: ContactMVVM)
    func saveContact(name: String, phone: String, avatar: String?) -> Bool
    func updateContact(name: String, phone: String, avatar: String?) -> Bool
    func updateAvatar(avatar: Avatar)
}

class ContactDetailsViewModel: ContactDetailsViewModelProtocol {
    
    let contactName = MutableProperty<String?>(nil)
    let contactPhone = MutableProperty<String?>(nil)
    let contactAvatar = MutableProperty<String?>(nil)
    
    var selectedContact: ContactMVVM?

    
    func selectContact(contact: ContactMVVM) {
        selectedContact = contact
        self.contactName.value = contact.nickname!
        self.contactPhone.value = contact.phoneNumber!
        self.contactAvatar.value = contact.avatarURL
    }
    
    
    func saveContact(name: String, phone: String, avatar: String?) -> Bool {
        
        let contact = ContactMVVM()
        contact.nickname = name
        contact.phoneNumber = phone
        contact.avatarURL = avatar
        
        return ExternalConnector.sharedManager().persistentManager.addToPersistentContact(contact)
    }
    
    
    func updateContact(name: String, phone: String, avatar: String?) -> Bool {
        
        selectedContact!.nickname = name
        selectedContact!.phoneNumber = phone
        selectedContact!.avatarURL = avatar
        
        return ExternalConnector.sharedManager().persistentManager.updateContact(selectedContact!)
    }
    
    func updateAvatar(avatar: Avatar) {
        selectedContact?.avatarURL = avatar.url
        contactAvatar.value = avatar.url
    }
}
