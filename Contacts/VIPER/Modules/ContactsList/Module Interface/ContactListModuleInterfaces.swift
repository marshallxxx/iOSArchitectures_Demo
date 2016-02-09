//
//  ModuleInterfaces.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

@objc protocol ContactsListPresenterInterface: class {
    weak var view: ContactsListViewInterface? { get set }
    weak var wireframe:ContactsListWireframe? { get set }
    
    func addNewContact()
    func refreshData()
    func numberOfSections() -> Int
    func sectionsName() -> [String]
    func sectionName(section:Int) -> String
    func numberOfRowsInSection(section: Int) -> Int
    func setupContactInfo(section:Int, index:Int, setup:(name:String?, phone:String?, avatarURL:String?) -> ())
    func editContact(section:Int, index: Int)
}

@objc protocol ContactsListViewInterface: class {
    var eventHandler: ContactsListPresenterInterface? { get set }
    
    func dataRefreshed()
}

@objc protocol ContactListInteractorInput {
    func findAllContacts()
}

@objc protocol ContactListInteractorOutput {
    func foundAllContacts(contacts: AllContactsSections)
}
