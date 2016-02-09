//
//  ContactsListPresenter.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactsListPresenter: NSObject, ContactsListPresenterInterface, ContactListInteractorOutput, ContactDetailsModuleDelegate {

    weak var view: ContactsListViewInterface?
    weak var wireframe:ContactsListWireframe?
    var interactor: ContactListInteractorInput
    
    private var data: AllContactsSections?
    private var contactIDForEdition: Int?
    
    init(interactor:ContactListInteractorInput) {
        self.interactor = interactor
        super.init()
    }
    
    // MARK: ContactsListPresenterInterface
    func addNewContact() {
        contactIDForEdition = -1
        wireframe!.presentContactDetails(view!)
    }
    
    func refreshData() {
        interactor.findAllContacts()
    }
    
    func numberOfSections() -> Int {
        return data?.getNumberSection() ?? 0
    }
    
    func sectionsName() -> [String] {
        return data?.getSectionsNames() ?? []
    }
    
    func sectionName(section:Int) -> String {
        return data!.allSections[section].name
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return data?.getContactsNumberForSection(section) ?? 0
    }
    
    func setupContactInfo(section:Int, index:Int, setup:(name:String?, phone:String?, avatarURL:String?) -> ()) {
        let info = data?.allSections[section].contacts[index]
        setup(name: info?.name, phone: info?.phone, avatarURL: info?.avatarUrl)
    }
    
    func editContact(section:Int, index: Int) {
        contactIDForEdition = data?.allSections[section].contacts[index].contactID
        wireframe!.presentContactDetails(view!)
    }
    
    // MARK: ContactListInteractorOutput
    func foundAllContacts(contacts: AllContactsSections) {
        data = contacts
        view!.dataRefreshed()
    }
    
    // MARK: ContactDetailsModuleDelegate
    
    func contactDetailsDidEndEditing() {
        interactor.findAllContacts()
    }
    
    func editingContactID() -> Int {
        return contactIDForEdition ?? -1
    }
    
}
