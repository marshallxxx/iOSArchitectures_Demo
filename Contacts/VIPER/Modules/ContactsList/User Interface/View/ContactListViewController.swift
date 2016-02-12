//
//  ContactsListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController, ContactsListViewInterface {

    var eventHandler: ContactsListPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventHandler?.refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ContactsListViewInterface
    
    func dataRefreshed() {
        tableView.reloadData()
    }
    
    // MARK: IBActions
    
    @IBAction func newContactButtonPressed(sender: AnyObject) {
        eventHandler?.addNewContact()
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return eventHandler!.numberOfSections()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventHandler!.sectionName(section)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventHandler!.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as? ContactCell
        
        eventHandler!.setupContactInfo(indexPath.section, index: indexPath.row) { (name, phone, avatarURL) -> () in
            
            cell?.nicknameLabel?.text = name
            cell?.phoneLabel?.text = phone
            
            if let url = avatarURL {
                cell?.avatarIV?.imageFromUrl(url)
            } else {
                cell?.avatarIV?.image = UIImage(named: "noUser")
            }

        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        eventHandler?.editContact(indexPath.section, index: indexPath.row)
    }
    
}
