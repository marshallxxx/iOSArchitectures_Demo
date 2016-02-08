//
//  AvatarListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class AvatarListViewController: UICollectionViewController {

    var viewModel: AvatarListViewModelProtocol!
    var selectedItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "goBack:")
        navigationItem.leftBarButtonItem = leftItem
        
        viewModel.getAvatars().startWithNext { _ -> () in
            self.collectionView?.reloadData()
        }
    }
    
    
    // MARK: IBActions
    
    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.Segue_ToEditContact {
            let VC = segue.destinationViewController as? ContactDetailsViewController
            VC?.viewModel?.updateAvatar(viewModel.getSelectedAvatar())
            
        }
    }
}

extension AvatarListViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAvatarsCount()
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AvatarCell", forIndexPath: indexPath) as! AvatarCell
        
        cell.viewModel = viewModel.avatartAtIndex(indexPath.item)
        
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        viewModel.selectWithIndex(indexPath.item)
        performSegueWithIdentifier(Constants.Segue_ToEditContact, sender: self)
    }
    
}

