//
//  MTTService.swift
//  MTTReProject
//
//  Created by Evghenii Nicolaev on 1/29/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {

    func getAvatarList(callback: (NSError?, [Avatar]?) -> ())
    
}

class NetworkService: NetworkServiceProtocol {
    
    private let serviceEndpoint = "http://private-3e309-contacts29.apiary-mock.com"
    
    private let urlContacts = "contacts"
    
    private let responseKeyResults = "results"
    
    private var restCaller: RestAPIProtocol?
    
    init(rest: RestAPIProtocol) {
        restCaller = rest
        
    }
    
    // MARK: NetworkServiceProtocol
    
    func getAvatarList(callback: (NSError?, [Avatar]?) -> ()) {
        
        restCaller?.doGet("\(serviceEndpoint)/\(urlContacts)", callback: { (error, response) -> () in
            
            weak var wefl = self
            if let err = error {
                callback(err, nil)
            } else {
                let avatarsArray = response?[(wefl!.responseKeyResults)] as? [AnyObject]
                
                let avatars = Avatar.arrayOfModelsFromDictionaries(avatarsArray) as? [Avatar]
                
                callback(nil, avatars)
            }
            
        })
    }
    
}
