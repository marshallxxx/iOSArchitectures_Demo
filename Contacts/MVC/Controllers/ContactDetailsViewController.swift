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

    var contact:ContactMVC?
    var isEditable: Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = contact {
            isEditable = true
            contactName?.text = contact?.nickname
            contactPhone?.text = contact?.phoneNumber
            contactAvatar?.imageFromUrl((contact?.avatarURL)!)
            
        } else {
            contact = ContactMVC()
        }

    }
    
    
    // MARK: IBActions
    @IBAction func pickContactAvatart(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToAvatars, sender: self)
    }
    
    @IBAction func saveNewContact(sender: AnyObject) {
        if let name = contactName?.text, let phone = contactPhone?.text{
            contact!.nickname = name
            contact!.phoneNumber = phone
            
            let result = ExternalConnector.sharedManager().persistentManager.addToPersistentContact(contact!)
            
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
