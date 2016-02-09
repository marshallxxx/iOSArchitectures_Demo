//
//  AvatarChooserModuleInterface.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

@objc protocol AvatarChooserViewInterface {
    var eventHandler: AvatarChooserPresenterInterface! { get set }
    
    func avatarLoadFail()
    func dataRefreshed()
}

@objc protocol AvatarChooserPresenterInterface {
    weak var view: AvatarChooserViewInterface? { get set }
    weak var wireframe: AvatarChooserWireframe? { get set }
    
    func refreshData()
    func numberOfAvatars() -> Int
    func setupAvatarInfo(index:Int, setup:(name:String?, avatarURL:String?) -> ())
    func chooseAvatar(index:Int)
}

@objc protocol AvatarChooserInteractorInput {
    func findAvailableAvatars()
}

@objc protocol AvatarChooserInteractorOutput {
    func foundAvailableAvatars(avatars:[Avatar])
    func failedToLoadAvailableAvatars()
}

@objc protocol AvatarChooserModuleDelegate {
    func didChooseAvatar(avatarURL: String?)
}