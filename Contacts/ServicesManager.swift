//
//  ServiceManager.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ServiceManager<ContactsModelType: ModelConvertorProtocol> {

    var persistentManager: PersistentManager<ContactsModelType>
    var networkManager: NetworkServiceProtocol
    
    init(persistentSolution:PersistentManager<ContactsModelType>, networkServiceSolution: NetworkServiceProtocol) {
        persistentManager = persistentSolution
        networkManager = networkServiceSolution
    }
    
//    class func sharedInstance() -> ServiceManager {
////        struct Static {
////            static var onceToken: dispatch_once_t = 0
////            static var instance: ServiceManager? = nil
////        }
////        
////        dispatch_once(&Static.onceToken) {
////            Static.instance = ServiceManager(persistentSolution: <#T##PersistentManager<ContactsModelType>#>, networkServiceSolution: <#T##NetworkServiceProtocol#>)
////        }
////        
////        return Static.instance!
//    }
    
}
