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
    
    @IBAction func newContactButtonPressed(sender:AnyObject) {
        eventHandler?.addNewContact()
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return eventHandler!.numberOfSections()
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return eventHandler!.sectionsName()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventHandler!.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell")
        
        return cell!
    }
    
}
