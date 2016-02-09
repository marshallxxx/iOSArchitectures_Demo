//
//  ContactDetailsPresenter.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactDetailsPresenter: NSObject, ContactDetailsPresenterInterface, ContactDetailsInteractorOutput, AvatarChooserModuleDelegate {
    
    weak var view: ContactDetailsViewInterface?
    weak var wireframe: ContactDetailsWireframe?
    var interactor:ContactDetailsInteractorInput
    
    weak var moduleDelegate: ContactDetailsModuleDelegate?
    
    var displayData:ContactDetailsDisplayData?
    
    init(interactor: ContactDetailsInteractorInput) {
        self.interactor = interactor
        super.init()
    }
    
    // MARK: ContactDetailsPresenterInterface
    func chooseAvatar() {
        wireframe!.presentAvatarChooser(view!)
    }
    
    func saveContact() {
        let id = moduleDelegate?.editingContactID() ?? -1
        interactor.saveContact(id, nickname: view!.getContactNickname(), phone: view!.getContactPhone(), avatarUrl: view!.getAvatarUrl())
        moduleDelegate?.contactDetailsDidEndEditing()
        wireframe!.dismissViewController()
    }
    
    func reloadData() {
        if let contactID = moduleDelegate?.editingContactID() {
            interactor.retrieveContactDetails(contactID)
        } else {
            displayData = nil
        }
    }
    
    func contactDetailsRetrieved(contactDetails:ContactDetailsDisplayData?) {
        view?.setContactNickname(contactDetails?.nickname)
        view?.setContactPhone(contactDetails?.phone)
        view?.setAvatarUrl(contactDetails?.avatarUrl)
    }
    
    // MARK: AvatarChooserModuleDelegate 
    
    func didChooseAvatar(avatarURL: String?) {
        view?.setAvatarUrl(avatarURL)
    }
    
}
