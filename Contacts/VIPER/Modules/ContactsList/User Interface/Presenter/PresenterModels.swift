//
//  PresenterModels.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

@objc class AllContactsSections: NSObject {
    
    var allSections: [ContactSection]
    
    init(sections: [ContactSection]) {
        allSections = sections
        super.init()
    }
    
    func getNumberSection() -> Int {
        return allSections.count
    }
    
    func getSectionsNames() -> [String] {
        return allSections.map({ (contact) -> String in
            return contact.name
        })
    }
    
    func getContactsNumberForSection(section: Int) -> Int {
        return allSections[section].contacts.count
    }
    
}

@objc class ContactSection: NSObject {
    var name: String
    var contacts: [ContactDisplayData]
    
    init(name: String) {
        self.name = name
        contacts = []
        super.init()
    }
}

@objc class ContactDisplayData: NSObject {
    var name: String?
    var phone: String?
    var avatarUrl: String?
    var contactID: Int
    
    init(contactID: Int, name: String?, phone: String?, avatarUrl: String?) {
        self.contactID = contactID
        self.name = name
        self.phone = phone
        self.avatarUrl = avatarUrl
        super.init()
    }
}
