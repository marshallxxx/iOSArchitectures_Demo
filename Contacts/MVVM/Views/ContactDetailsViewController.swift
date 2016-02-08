//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    var isEditable: Bool = false
    
    var viewModel: ContactDetailsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel where isEditable {
            viewModel.contactName.producer
                .on(next: { self.contactName!.text = $0 })
                .start()
            viewModel.contactPhone.producer
                .on(next: { self.contactPhone!.text = $0 })
                .start()
            viewModel.contactAvatar.producer
                .on(next: {  self.contactAvatar?.imageFromUrl($0) })
                .start()            
        }
    }
    
    @IBOutlet weak var contactAvatar: UIImageView?
    @IBOutlet weak var contactName: UITextField?
    @IBOutlet weak var contactPhone: UITextField?
    
    
    // MARK: IBActions
    @IBAction func pickContactAvatart(sender: AnyObject) {
        performSegueWithIdentifier(Constants.Segue_ToAvatars, sender: self)
    }
    
    
    @IBAction func saveNewContact(sender: AnyObject) {
        if let name = contactName?.text, let phone = contactPhone?.text{
            
            var result:Bool
            
            if isEditable {
                result = viewModel!.updateContact(name, phone: phone, avatar: viewModel?.contactAvatar.value)
            } else {
                result = viewModel!.saveContact(name, phone: phone, avatar: viewModel?.contactAvatar.value)
            }
            
            if result {
                navigationController?.popViewControllerAnimated(true)
            } else {
                let alert = UIAlertView(title: "Error", message: "Contact already exists", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
            }
        }
    }
    
    
    @IBAction func unwindForSegue(unwindSegue: UIStoryboardSegue) {
        contactAvatar?.imageFromUrl((viewModel?.contactAvatar.value)!)
    }
    
}
