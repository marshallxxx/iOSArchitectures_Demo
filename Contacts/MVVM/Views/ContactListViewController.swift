//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit
import CoreData
import ReactiveCocoa
import Swinject

class ContactListViewController: UITableViewController {
    
    var viewModel: ContactListViewModelProtocol!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshContent()
        tableView.reloadData()
    }
    
    // MARK: IBActions
    @IBAction func showAddNewContact(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
        case Constants.Segue_ToDetails:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
                destination.viewModel = self.viewModel.contactDetailViewModel
                destination.isEditable = true
            }
            break;
        default: break;
        }
    }
}


// MARK: UITableViewDataSource
extension ContactListViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllContactsCount()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
        cell.viewModel = viewModel.cellModelAtIndex(indexPath.row)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            viewModel.removeWithIndex(indexPath.row)
            tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDelegate
extension ContactListViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel?.selectWithIndex(indexPath.row)
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
}
