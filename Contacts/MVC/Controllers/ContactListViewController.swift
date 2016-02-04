//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UITableViewController {
    
    var allContacts:[ContactMVC] = []
    var selectedContact:ContactMVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allContacts = ExternalConnector.sharedServicesManager().persistentManager.getAllPersistentContacts() as! [ContactMVC]
        
        // Mock
        
//        let phones = ["098765434", "1089747", "19824701", "09174014"]
//        let names = ["James", "Franko", "Luis", "Jully"]
//        
//        for (index, name) in names.enumerate() {
//            let contact = ContactMVC()
//            
//            contact.phoneNumber = phones[index]
//            contact.nickname = name
//            contact.avatarURL = nil
//            
//            ExternalConnector.sharedServicesManager().persistentManager.addToPersistentContact(contact)
//        }
        
        
        
    }

    // MARK: IBActions
    
    @IBAction func showAddNewContact(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.Cell_ContactCell) as! ContactCell
        
        let contact = allContacts[indexPath.row]
        
        cell.nicknameLabel?.text = contact.nickname
        cell.phoneNumberLabel?.text = contact.phoneNumber
        
        if let imageUrl = contact.avatarURL {
            cell.avatarIV?.imageFromUrl(imageUrl)
        } else {
            cell.avatarIV?.image = UIImage(named:"noUser")
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = allContacts[indexPath.row]
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
        case Constants.Segue_ToDetails:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
                destination.contact = selectedContact
            }
        case Constants.Segue_ToNewEntry:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
                destination.contact = nil
            }
            break
        default:
            assertionFailure("There shoudn't be another segues")
        }
    }
    
}
