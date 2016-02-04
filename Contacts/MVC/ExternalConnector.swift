//
//  ExternalConnector.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ExternalConnector {
    static func sharedServicesManager() -> ServicesManager<ContactMVC> {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ServicesManager<ContactMVC>? = nil
        }
        
        dispatch_once(&Static.onceToken) { () -> Void in
            
            let persistentOption = CoreDataManager()
            let persistentSolution = PersistentManager<ContactMVC>(persistentOption: persistentOption)
            
            let restCaller = RestAPICaller()
            let networkSerciveSolution = NetworkService(rest: restCaller)
            
            Static.instance = ServicesManager<ContactMVC>(persistentSolution: persistentSolution, networkServiceSolution: networkSerciveSolution)
        }
        
        return Static.instance!
    }
}
