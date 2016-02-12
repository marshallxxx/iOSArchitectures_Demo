//
//  ContactCell.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    internal var viewModel: ContactCellViewModel? {
        didSet {
            nicknameLabel!.text = viewModel?.contactName
            phoneNumberLabel!.text = viewModel?.contactPhone
            
            if let imageUrl = viewModel?.contactAvatar {
                avatarIV?.imageFromUrl(imageUrl)
            } else {
                avatarIV?.image = UIImage(named: "noUser")
            }
        }
    }
    
    
    @IBOutlet weak var nicknameLabel: UILabel?
    @IBOutlet weak var phoneNumberLabel: UILabel?
    @IBOutlet weak var avatarIV: UIImageView?
}
