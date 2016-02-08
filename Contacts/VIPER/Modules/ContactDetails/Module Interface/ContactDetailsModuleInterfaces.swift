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
    
    func chooseAvatar()
    func saveContact()
}

@objc protocol ContactDetailsViewInterface {
    var eventHandler: ContactDetailsPresenterInterface? { get set }
    
    func getContactNickname() -> String
    func getContactPhone() -> String
}

@objc protocol ContactDetailsInteractorInput {
//    func saveContact(name:String)
}

@objc protocol ContactDetailsInteractorOutput {
    
}
