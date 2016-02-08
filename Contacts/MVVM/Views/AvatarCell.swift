//
//  AvatarCell.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    internal var viewModel: AvatarCellViewModel? {
        didSet {
            avatarTitle!.text = viewModel?.avatarTitle
            
            if let imageUrl = viewModel?.avatarUrl {
                avatarImage?.imageFromUrl(imageUrl)
            }
            else {
                avatarImage?.image = UIImage(named: "noUser")
            }
        }
    }
    
    @IBOutlet weak var avatarImage: UIImageView?
    @IBOutlet weak var avatarTitle: UILabel?
}
