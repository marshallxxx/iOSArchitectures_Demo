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
    
    var allContacts:[ContactMVC] = ExternalConnector.sharedServicesManager().persistentManager.getAllPersistentContacts() as! [ContactMVC]
    
    var selectedContact:ContactMVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.Cell_ContactCell) as! ContactCell
        
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
