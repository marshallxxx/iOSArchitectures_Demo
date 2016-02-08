//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController, ContactDetailsViewInterface {
    
    var eventHandler: ContactDetailsPresenterInterface?
    
    
    // MARK: IBActions
    
    @IBAction func avatarPressed(sender: AnyObject) {
        eventHandler?.chooseAvatar()
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        eventHandler!.saveContact()
    }
    
    func getContactNickname() -> String {
        return ""
    }
    
    func getContactPhone() -> String {
        return ""
    }
    
}
