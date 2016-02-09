//
//  PersistentManager.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

@objc protocol ModelConvertorProtocol {
    init()
    
    var contactID: Int { get set }
    var phoneNumber: String? { get set }
    var avatarURL: String? { get set }
    var nickname: String? { get set }
}

protocol PersistentManagerProtocol {
    typealias ReturnType
    
    func getAllPersistentContacts() -> [ReturnType]?
    func getContactWithID(contactID: Int) -> ReturnType?
    func addToPersistentContact(newObject:ReturnType) -> Bool
    func removePersistentObject(objectToRemove:ReturnType) -> Bool
    func updateContact(contact:ReturnType) -> Bool
}

class PersistentManager<T: ModelConvertorProtocol>: PersistentManagerProtocol {
    
    typealias ReturnType = ModelConvertorProtocol
    
    var persistentManager: PersistenStoreProtocol
    
    init(persistentOption: PersistenStoreProtocol) {
        persistentManager = persistentOption
    }
    
    func getAllPersistentContacts() -> [ReturnType]? {
        
        var resultContacts = [ReturnType]()
        
        if let allContacts = persistentManager.getAllContacts() {
            
            for contact in allContacts {
                let t = T()
                
                t.nickname = contact.nickname
                t.phoneNumber = contact.phoneNumber
                t.avatarURL = contact.avatarURL
                t.contactID = contact.contactID
                
                resultContacts.append(t)
            }
        }
        
        return resultContacts
    }
    
    func getContactWithID(contactID: Int) -> ReturnType? {
        
        if let returnContact = persistentManager.getContactWithID(contactID) {
            let t = T()
            t.contactID = returnContact.contactID
            t.nickname = returnContact.nickname
            t.phoneNumber = returnContact.phoneNumber
            t.avatarURL = returnContact.avatarURL
            
            return t
        }
        
        return nil
    }
    
    func addToPersistentContact(newObject:ReturnType) -> Bool {
        let matchContacts = persistentManager.getContacts("phoneNumber", contactValue: newObject.phoneNumber ?? "-1")
        
        if let contacts = matchContacts where
            contacts.count == 0 {
            let contact = persistentManager.newContact()
            
            contact.phoneNumber = newObject.phoneNumber
            contact.nickname = newObject.nickname
            contact.avatarURL = newObject.avatarURL
            
            persistentManager.saveContext()
            
            return true
        } else {
            return false
        }
    }
    
    func updateContact(contact:ReturnType) -> Bool {
        if let persistentContact = persistentManager.getContactWithID(contact.contactID) {
            
            persistentContact.nickname = contact.nickname
            persistentContact.phoneNumber = contact.phoneNumber
            persistentContact.avatarURL = contact.avatarURL
            
            return persistentManager.updateContact(persistentContact)
            
        } else {
            return false
        }
    }
    
    func removePersistentObject(objectToRemove:ReturnType) -> Bool {
        return persistentManager.removeContactWithID(objectToRemove.contactID )
    }
    
}