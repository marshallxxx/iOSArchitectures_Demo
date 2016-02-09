//
//  AvatarChooserInteractor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class AvatarChooserInteractor: NSObject, AvatarChooserInteractorInput {

    private var externalServices: ServicesManager<ContactVIPER>
    weak var output: AvatarChooserInteractorOutput?
    
    override init() {
        externalServices = ExternalConnector.sharedManager()
        super.init()
    }
    
    
    // MARK: AvatarChooserInteractorInput
    
    func findAvailableAvatars() {
        
        externalServices.networkManager.getAvatarList { [weak self] (error, avatars) -> () in
            
            if error != nil || avatars == nil {
                self?.output?.failedToLoadAvailableAvatars()
            } else {
                self?.output?.foundAvailableAvatars(avatars!)
            }
            
        }
        
    }
    
}
