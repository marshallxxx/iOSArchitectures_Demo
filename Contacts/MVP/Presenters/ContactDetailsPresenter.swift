//
//  ContactDetailsPresentor.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

protocol ContactDetailsPresenterProtocol: class {
    init(view: ContactDetailsViewProtocol)

    var currentContact: ContactMVP { get set }
    
    func getContactAvatarURL() -> String?
    func setupAvatarURL(url: String?)
    func getContactNickname() -> String?
    func setupContactNickname(nickname: String?)
    func getContactPhoneNumber() -> String?
    func setupContactPhoneNumber(phoneNumber: String?)
    func saveContact()
}

class ContactDetailsPresenter: NSObject, ContactDetailsPresenterProtocol {

    unowned var view: ContactDetailsViewProtocol
    
    private var isEditable: Bool = false
    
    var currentContactTemp: ContactMVP?
    var currentContact: ContactMVP {
        get {
            if currentContactTemp == nil {
                currentContactTemp = ContactMVP()
                isEditable = false
            }
            return currentContactTemp!
        }
        set {
            isEditable = true
            currentContactTemp = newValue
        }
    }
    
    required init(view: ContactDetailsViewProtocol) {
        self.view = view
        
        super.init()
    }
    
    // MARK: ContactDetailsPresenterProtocol
    func setupAvatarURL(url: String?) {
        currentContact.avatarURL = url
    }
    
    func getContactAvatarURL() -> String? {
        return currentContact.avatarURL
    }
    
    func setupContactNickname(nickname: String?) {
        currentContact.nickname = nickname
    }
    
    func getContactNickname() -> String? {
        return currentContact.nickname
    }
    
    func setupContactPhoneNumber(phoneNumber: String?) {
        currentContact.phoneNumber = phoneNumber
    }
    
    func getContactPhoneNumber() -> String? {
        return currentContact.phoneNumber
    }
    
    func saveContact() {
        
        var result: Bool
        
        if isEditable {
            result = ExternalConnector.sharedManager().persistentManager.updateContact(currentContact)
        } else {
            result = ExternalConnector.sharedManager().persistentManager.addToPersistentContact(currentContact)
        }
        
        view.contactSavedWithResult(result)
    }
    
}
