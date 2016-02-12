//
//  AvatarListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

protocol AvatarListViewProtocol: class {
    func dataReloaded()
    func updateCell(avatarTitle: String?, avatarURL: String?)
}

class AvatarListViewController: UICollectionViewController, AvatarListViewProtocol {

    var presenter: AvatarListPresenterProtocol?
    
    private var currentCell: AvatarCell?
    private var selectedCellIndex: Int = -1
    
    // MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = AvatarListPresenter(view: self)
        
        let leftItem = UIBarButtonItem(title: "Cancel", style: .Done, target: self, action: "goBack:")
        navigationItem.leftBarButtonItem = leftItem
    }

    // MARK: Navigation
    
    func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier! {
        case Constants.SegueToEditContact:
            if let destinationVC = segue.destinationViewController as? ContactDetailsViewController {
                destinationVC.presenter!.setupAvatarURL(presenter!.getAvatarUrlAtIndex(selectedCellIndex))
            }
        default:
            assertionFailure("No other known segues for controller")
        }
        
    }

    // MARK: AvatarListViewProtocol
    func dataReloaded() {
        collectionView?.reloadData()
    }
    
    // MARK: CollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.numberOfAvatars()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        currentCell = collectionView.dequeueReusableCellWithReuseIdentifier("AvatarCell", forIndexPath: indexPath) as? AvatarCell
        presenter?.presentContact(indexPath.row)
        return currentCell!
    }
    
    func updateCell(avatarTitle: String?, avatarURL: String?) {
        
        currentCell!.avatarTitle?.text = avatarTitle
        
        if let imageUrl = avatarURL {
            currentCell!.avatarImage?.imageFromUrl(imageUrl)
        } else {
            currentCell!.avatarImage?.image = UIImage(named:"noUser")
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCellIndex = indexPath.item
        performSegueWithIdentifier(Constants.SegueToEditContact, sender: self)
    }
}
