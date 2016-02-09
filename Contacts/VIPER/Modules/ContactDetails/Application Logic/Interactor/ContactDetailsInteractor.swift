//
//  ContactDetailsInteractor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactDetailsInteractor: NSObject, ContactDetailsInteractorInput {

    private var externalServices: ServicesManager<ContactVIPER>
    weak var output: ContactDetailsInteractorOutput?
    
    override init() {
        externalServices = ExternalConnector.sharedManager()
        super.init()
    }
    
    func saveContact(contactID: Int, nickname:String?, phone: String?, avatarUrl: String?) {
        
        var editingContact:ContactVIPER?
        
        if contactID > 0 {
            editingContact = externalServices.persistentManager.getContactWithID(contactID) as? ContactVIPER
        }
        
        var savingContact: ContactVIPER
        
        if editingContact == nil {
            savingContact = ContactVIPER()
        } else {
            savingContact = editingContact!
        }
        
        savingContact.nickname = nickname
        savingContact.phoneNumber = phone
        savingContact.avatarURL = avatarUrl
        
        if editingContact == nil {
            externalServices.persistentManager.addToPersistentContact(savingContact)
        } else {
            externalServices.persistentManager.updateContact(savingContact)
        }
    }
    
    func retrieveContactDetails(contactID:Int) {
        
        var displayData: ContactDetailsDisplayData?
        
        if let contact = externalServices.persistentManager.getContactWithID(contactID) as? ContactVIPER {
            
            displayData = ContactDetailsDisplayData()
            
            displayData?.nickname = contact.nickname
            displayData?.phone = contact.phoneNumber
            displayData?.avatarUrl = contact.avatarURL
            
        }
        
        output?.contactDetailsRetrieved(displayData)
        
    }
    
}
