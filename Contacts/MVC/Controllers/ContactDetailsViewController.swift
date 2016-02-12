//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var contactAvatar: UIImageView?
    @IBOutlet weak var contactName: UITextField?
    @IBOutlet weak var contactPhone: UITextField?

    var contact: ContactMVC?
    var isEditable: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = contact {
            isEditable = true
            contactName?.text = contact?.nickname
            contactPhone?.text = contact?.phoneNumber
            
            if let avatarURL = contact?.avatarURL {
                contactAvatar?.imageFromUrl(avatarURL)
            }
            
        } else {
            contact = ContactMVC()
        }

    }
    
    
    // MARK: IBActions
    @IBAction func pickContactAvatart(sender: AnyObject) {
        performSegueWithIdentifier(Constants.SegueToAvatars, sender: self)
    }
    
    @IBAction func saveNewContact(sender: AnyObject) {
        if let name = contactName?.text, let phone = contactPhone?.text {
            contact!.nickname = name
            contact!.phoneNumber = phone
            
            var result: Bool
            
            if isEditable {
                result = ExternalConnector.sharedManager().persistentManager.updateContact(contact!)
            } else {
                result = ExternalConnector.sharedManager().persistentManager.addToPersistentContact(contact!)
            }
            
            if result {
                navigationController?.popViewControllerAnimated(true)
            } else {
                let alert = UIAlertView(title: "Error", message: "Contact already exists", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
            }
        }

    }
    
    @IBAction func unwindForSegue(unwindSegue: UIStoryboardSegue) {
        contactAvatar?.imageFromUrl((contact?.avatarURL)!)
    }
    
}
