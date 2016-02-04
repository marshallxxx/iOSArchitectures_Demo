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
    
    var allContacts:[Contact] = []
    
    override func viewDidLoad() {

    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.Cell_ContactCell) as! ContactCell
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
