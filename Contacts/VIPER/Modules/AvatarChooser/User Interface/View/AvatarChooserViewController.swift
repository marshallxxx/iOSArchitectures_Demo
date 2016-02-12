//
//  AvatarChooserViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class AvatarChooserViewController: UICollectionViewController, AvatarChooserViewInterface {
    var eventHandler: AvatarChooserPresenterInterface!
    
    // MARK: Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
     
        eventHandler.refreshData()
    }
    
    // MARK: AvatarChooserViewInterface
    func avatarLoadFail() {
        let alert = UIAlertView(title: "Error", message: "Failed to retrieve avatars", delegate: self, cancelButtonTitle: "Ok")
        alert.show()
    }
    
    func dataRefreshed() {
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventHandler.numberOfAvatars() ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AvatarCell", forIndexPath: indexPath) as? AvatarCell
        
        eventHandler.setupAvatarInfo(indexPath.row, setup: { (name, avatarURL) -> () in
            cell.avatarIV?.imageFromUrl(avatarURL)
            cell.avatarNameLabel?.text = name
        })
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        eventHandler!.chooseAvatar(indexPath.row)
    }
    
}
