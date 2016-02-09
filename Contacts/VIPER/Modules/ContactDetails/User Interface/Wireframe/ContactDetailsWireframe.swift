//
//  ContactDetailsWireframe.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactDetailsWireframe: NSObject {

    var presenter: ContactDetailsPresenterInterface
    var avatarChooserWireframe: AvatarChooserWireframe?
    
    @objc init(presenter:ContactDetailsPresenterInterface) {
        self.presenter = presenter
        super.init()
    }
    
    func presentContactDetailsViewFromViewController(viewController: UIViewController) {
        let view = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ContactDetailsVC")
        presenter.view = view as? ContactDetailsViewInterface
        presenter.view!.eventHandler = presenter
        
        viewController.navigationController?.pushViewController(view, animated: true)
    }
    
    func presentAvatarChooser(view: AnyObject) {
        avatarChooserWireframe!.presentAvatarChooserViewFromViewController(view as! UIViewController)
    }
    
    func dismissViewController() {
        (presenter.view as! UIViewController).navigationController!.popViewControllerAnimated(true)
    }
    
}
