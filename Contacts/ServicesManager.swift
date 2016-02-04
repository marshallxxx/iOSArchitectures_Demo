//
//  ServiceManager.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ServicesManager<ContactsModelType: ModelConvertorProtocol> {

    var persistentManager: PersistentManager<ContactsModelType>
    var networkManager: NetworkServiceProtocol
    
    init(persistentSolution:PersistentManager<ContactsModelType>, networkServiceSolution: NetworkServiceProtocol) {
        persistentManager = persistentSolution
        networkManager = networkServiceSolution
    }
}