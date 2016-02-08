//
//  ContactsListPresenter.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactsListPresenter: NSObject, ContactsListPresenterInterface, ContactListInteractorOutput {

    weak var view: ContactsListViewInterface?
    weak var wireframe:ContactsListWireframe?
    var interactor: ContactListInteractorInput
    
    private var data: AllContactsSections?
    
    init(interactor:ContactListInteractorInput) {
        self.interactor = interactor
        super.init()
    }
    
    // MARK: ContactsListPresenterInterface
    func addNewContact() {
        wireframe!.presentContactDetails(view!)
    }
    
    func refreshData() {
        interactor.findAllContacts()
    }
    
    func numberOfSections() -> Int {
        return data?.getSectionNumber() ?? 0
    }
    
    func sectionsName() -> [String] {
        return data?.getSectionsNames() ?? []
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return data?.getContactsNumberForSection(section) ?? 0
    }
    
    // MARK: ContactListInteractorOutput
    func foundAllContacts(contacts: AllContactsSections) {
        data = contacts
        view!.dataRefreshed()
    }
    
}
