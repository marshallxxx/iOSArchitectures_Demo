//
//  ExternalConnector.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ExternalConnector {
    static func sharedManager() -> ServicesManager<ContactMVP> {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ServicesManager<ContactMVP>? = nil
        }
        
        dispatch_once(&Static.onceToken) { () -> Void in
            
            let persistentOption = CoreDataManager()
            let persistentSolution = PersistentManager<ContactMVP>(persistentOption: persistentOption)
            
            let restCaller = RestAPICaller()
            let networkSerciveSolution = NetworkService(rest: restCaller)
            
            Static.instance = ServicesManager<ContactMVP>(persistentSolution: persistentSolution, networkServiceSolution: networkSerciveSolution)
        }
        
        return Static.instance!
    }
}
