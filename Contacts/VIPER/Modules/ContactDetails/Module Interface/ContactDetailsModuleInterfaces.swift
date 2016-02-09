//
//  ModuleInterfaces.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

@objc protocol ContactDetailsPresenterInterface {
    weak var view: ContactDetailsViewInterface? { get set }
    weak var wireframe: ContactDetailsWireframe? { get set }
    
    func reloadData()
    func chooseAvatar()
    func saveContact()
}

@objc protocol ContactDetailsViewInterface {
    var eventHandler: ContactDetailsPresenterInterface? { get set }
    
    func getContactNickname() -> String?
    func setContactNickname(value:String?)
    func getContactPhone() -> String?
    func setContactPhone(value:String?)
    func getAvatarUrl() -> String?
    func setAvatarUrl(value:String?)
}

@objc protocol ContactDetailsInteractorInput {
    func saveContact(contactID: Int, nickname:String?, phone: String?, avatarUrl: String?)
    func retrieveContactDetails(contactID:Int)
}

@objc protocol ContactDetailsInteractorOutput {
    func contactDetailsRetrieved(contactDetails:ContactDetailsDisplayData?)
}

@objc protocol ContactDetailsModuleDelegate {
    func contactDetailsDidEndEditing()
    func editingContactID() -> Int
}
