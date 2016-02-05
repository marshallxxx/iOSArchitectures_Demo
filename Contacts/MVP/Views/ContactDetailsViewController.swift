//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

protocol ContactDetailsViewProtocol: class {
    func contactSavedWithResult(result:Bool)
}

class ContactDetailsViewController: UIViewController, ContactDetailsViewProtocol {

    var presenter: ContactDetailsPresenterProtocol?
    
    @IBOutlet weak var contactAvatar: UIImageView?
    @IBOutlet weak var contactName: UITextField?
    @IBOutlet weak var contactPhone: UITextField?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        presenter = ContactDetailsPresenter(view: self)
    }
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAvatar()
        contactName?.text = presenter?.getContactNickname()
        contactPhone?.text = presenter?.getContactPhoneNumber()
    }
    
    // MARK: IBActions
    @IBAction func saveContactPressed(sender: AnyObject) {
        presenter?.setupContactNickname(contactName?.text)
        presenter?.setupContactPhoneNumber(contactPhone?.text)
        presenter?.saveContact()
    }
    
    @IBAction func pickContactAvatart(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToAvatars, sender: self)
    }
    
    @IBAction func unwindForSegue(unwindSegue: UIStoryboardSegue) {
        setupAvatar()
    }
    
    // MARK: Helpers
    private func setupAvatar() {
        if let url = presenter?.getContactAvatarURL() {
            contactAvatar?.imageFromUrl(url)
        } else {
            contactAvatar?.image = UIImage(named: "noUser")
        }
    }
    
    // MARK: ContactDetailsViewProtocol
    func contactSavedWithResult(result:Bool) {
        if result {
            navigationController?.popViewControllerAnimated(true)
        } else {
            let alert = UIAlertView(title: "Error", message: "Contact already exists", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
        }
    }
    
}
