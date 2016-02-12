//
//  AvatarListViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class AvatarListViewController: UICollectionViewController {

    var avatarList = [Avatar]()
    var selectedItem: Avatar?

    override func viewDidLoad() {
        super.viewDidLoad()

        let leftItem = UIBarButtonItem(title: "Cancel", style: .Done, target: self, action: "goBack:")
        navigationItem.leftBarButtonItem = leftItem

        ExternalConnector.sharedManager().networkManager.getAvatarList {  (error, avatars) -> () in

            if let avatars = avatars {
                self.avatarList = avatars
                self.collectionView?.reloadData()
            }
        }
    }

    // MARK: IBActions

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.SegueToEditContact {
            let VC = segue.destinationViewController as? ContactDetailsViewController
            VC?.contact?.avatarURL = selectedItem?.url

        }
    }
}

extension AvatarListViewController {

    override func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return avatarList.count
    }

    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AvatarCell",
            forIndexPath: indexPath) as? AvatarCell

        let item = avatarList[indexPath.item]

        cell?.avatarTitle?.text = item.title
        cell?.avatarImage?.imageFromUrl(item.url)

        return cell!
    }

    override func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedItem = avatarList[indexPath.item]
        performSegueWithIdentifier(Constants.SegueToEditContact, sender: self)
    }
}
