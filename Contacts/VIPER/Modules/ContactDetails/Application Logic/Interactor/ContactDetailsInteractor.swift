//
//  ContactDetailsInteractor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactDetailsInteractor: NSObject, ContactDetailsInteractorInput {

    var externalServices: ServicesManager<ContactVIPER>
    weak var output: ContactDetailsInteractorOutput?
    
    override init() {
        externalServices = ExternalConnector.sharedManager()
        super.init()
    }
    
    
    
}
