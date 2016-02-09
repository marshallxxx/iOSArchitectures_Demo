//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController, ContactDetailsViewInterface {
    
    var eventHandler: ContactDetailsPresenterInterface?
    
    @IBOutlet weak var avatarIV: UIImageView?
    @IBOutlet weak var nicknameTF: UITextField?
    @IBOutlet weak var phoneNumberTF: UITextField?
    
    private var avatarURL: String?
    
    private var avatarUrl:String?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventHandler!.reloadData()
    }
    
    // MARK: IBActions
    
    @IBAction func avatarPressed(sender: AnyObject) {
        eventHandler?.chooseAvatar()
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        eventHandler!.saveContact()
    }
    
    func getContactNickname() -> String? {
        return nicknameTF?.text
    }
    
    func getContactPhone() -> String? {
        return phoneNumberTF?.text
    }
    
    func setContactNickname(value:String?) {
        nicknameTF?.text = value
    }
    
    func setContactPhone(value:String?) {
        phoneNumberTF?.text = value
    }
    
    func getAvatarUrl() -> String? {
        return avatarURL
    }
    
    func setAvatarUrl(value:String?) {
        avatarURL = value
        
        if let url = avatarURL {
            avatarIV?.imageFromUrl(url)
        } else {
            avatarIV?.image = UIImage(named: "noUser")
        }
    }
    
}
