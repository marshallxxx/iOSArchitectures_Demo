//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

protocol ContactListViewProtocol: class {
    func updateCell(nickname:String?, phoneNumber:String?, avatarURL:String?)
}

class ContactListViewController: UITableViewController, ContactListViewProtocol {
    
    var presenter:ContactListPresenterProtocol?
    private var currentCell: ContactCell?
    var selectedRow:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ContactListPresenter(view: self)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.refreshContent()
        tableView.reloadData()
    }
 
    // MARK: IBActions
    
    @IBAction func showAddNewContact(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.totalContactsNumber()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        currentCell = tableView.dequeueReusableCellWithIdentifier(Constants.Cell_ContactCell) as? ContactCell
        
        presenter!.presentContact(indexPath.row)
        
        return currentCell!
    }
    
    func updateCell(nickname:String?, phoneNumber:String?, avatarURL:String?) {
        currentCell?.nicknameLabel?.text = nickname
        currentCell?.phoneNumberLabel?.text = phoneNumber
        
        if let imageUrl = avatarURL {
            currentCell?.avatarIV?.imageFromUrl(imageUrl)
        } else {
            currentCell?.avatarIV?.image = UIImage(named:"noUser")
        }
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier(Constants.Segue_ToDetails, sender: self)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
        case Constants.Segue_ToDetails:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
                destination.presenter!.currentContact = presenter!.contactAtIndex(selectedRow)
            }
        case Constants.Segue_ToNewEntry:
            if let destination = segue.destinationViewController as? ContactDetailsViewController {
//                destination.contact = nil
            }
            break
        default:
            assertionFailure("There shoudn't be another segues")
        }
    }
    
}
