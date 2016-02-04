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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: IBActions
    @IBAction func pickContactAvatart(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToAvatars, sender: self)
    }
    
    @IBAction func saveNewContact(sender: AnyObject) {
        
    }
    
    @IBAction func unwindForSegue(unwindSegue: UIStoryboardSegue) {
        
    }
    
}
