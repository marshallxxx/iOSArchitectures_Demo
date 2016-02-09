//
//  ContactsListInteractor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

extension ContactVIPER {
    func toContactDisplayData() -> ContactDisplayData {
        return ContactDisplayData(contactID: self.contactID,
            name: self.nickname,
            phone: self.phoneNumber,
            avatarUrl: self.avatarURL)
    }
}

class ContactsListInteractor: NSObject, ContactListInteractorInput {

    var externalServices: ServicesManager<ContactVIPER>
    weak var output: ContactListInteractorOutput?
    
    override init() {
        externalServices = ExternalConnector.sharedManager()
        super.init()
    }
    
    func findAllContacts() {
        let contacts = externalServices.persistentManager.getAllPersistentContacts()! as! [ContactVIPER]
        output!.foundAllContacts(getSectionsData(contacts))
    }
    
    func getSectionsData(contacts:[ContactVIPER]) -> AllContactsSections {
        
        let sortedArray = contacts.sort{ $0.nickname < $1.nickname }
        var sections:[ContactSection] = []
        
        func appendSection(contacts:[ContactDisplayData], name: String) {
            let section = ContactSection(name: name)
            section.contacts = contacts
            sections.append(section)
        }
        
        var letter:String = ""
        var letterIndex = 0
        for (index, contact) in sortedArray.enumerate() {
            
            let firstLetter = String(contact.nickname?.characters.first ?? Character(" ") )
            
            if letter != firstLetter {
                appendSection(self.convertToDisplayData(Array(sortedArray[letterIndex..<index])), name: letter)
                letter = firstLetter
                letterIndex = index
            }
            
            if index == sortedArray.count - 1 {
                appendSection(self.convertToDisplayData(Array(sortedArray[letterIndex...index])), name: letter)
            }
            
        }
        
        return AllContactsSections(sections:sections)
    }
    
    func convertToDisplayData(contacts:[ContactVIPER]) -> [ContactDisplayData] {
        return contacts.map({ (contact) -> ContactDisplayData in
            return contact.toContactDisplayData()
        })
    }
    
}
