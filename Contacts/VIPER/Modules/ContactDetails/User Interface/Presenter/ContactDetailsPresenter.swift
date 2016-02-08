//
//  ContactDetailsPresenter.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactDetailsPresenter: NSObject, ContactDetailsPresenterInterface, ContactDetailsInteractorOutput {
    
    weak var view: ContactDetailsViewInterface?
    weak var wireframe: ContactDetailsWireframe?
    var interactor:ContactDetailsInteractorInput
    
    
    
    init(interactor: ContactDetailsInteractorInput) {
        self.interactor = interactor
        super.init()
    }
    
    // MARK: ContactDetailsPresenterInterface
    func chooseAvatar() {
        wireframe!.presentAvatarChooser(view!)
    }
    
    func saveContact() {

    }
    
}
