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
    func addToPersistentContact(newObject:ReturnType)
    func removePersistentObject(objectToRemove:ReturnType) -> Bool
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
                
                resultContacts.append(t)
            }
        }
        
        return resultContacts
    }
    
    func addToPersistentContact(newObject:ReturnType) {
        
        let contact = persistentManager.newContact()
        
        contact.phoneNumber = newObject.phoneNumber
        contact.nickname = newObject.nickname
        contact.avatarURL = newObject.avatarURL
        
        persistentManager.saveContext()

    }
    
    func removePersistentObject(objectToRemove:ReturnType) -> Bool {
        return persistentManager.removeContactWithID(objectToRemove.contactID )
    }
    
}