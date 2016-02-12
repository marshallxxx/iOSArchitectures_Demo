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
    
    var allContacts: [ContactMVC] = []
    var selectedContact: ContactMVC?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshContent()
    }
    
    func refreshContent() {
        allContacts = (ExternalConnector.sharedManager().persistentManager.getAllPersistentContacts() as? [ContactMVC])!
        tableView.reloadData()
    }
    
    
    // MARK: IBActions
    @IBAction func showAddNewContact(sender: AnyObject) {
        performSegueWithIdentifier(Constants.SegueToDetails, sender: self)
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.SegueToDetails:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
                destination.contact = selectedContact
            }
        case Constants.SegueToNewEntry:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
                destination.contact = nil
            }
            break
        default:
            assertionFailure("There shoudn't be another segues")
        }
    }
    
}


// MARK: UITableViewDataSource
extension ContactListViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellContactCell) as? ContactCell
        
        let contact = allContacts[indexPath.row]
        
        cell?.nicknameLabel?.text = contact.nickname
        cell?.phoneNumberLabel?.text = contact.phoneNumber
        
        if let imageUrl = contact.avatarURL {
            cell?.avatarIV?.imageFromUrl(imageUrl)
        } else {
            cell?.avatarIV?.image = UIImage(named:"noUser")
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let item = allContacts[indexPath.row]
            ExternalConnector.sharedManager().persistentManager.removePersistentObject(item)
            
            refreshContent()
        }
    }
}


// MARK: UITableViewDelegate
extension ContactListViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = allContacts[indexPath.row]
        performSegueWithIdentifier(Constants.SegueToDetails, sender: self)
    }
}
