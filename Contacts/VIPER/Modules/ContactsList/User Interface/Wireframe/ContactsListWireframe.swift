//
//  ContactsListWireframe.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class ContactsListWireframe: NSObject, InitialWireframeProtocol {

    var rootWireframe: RootWireframe
    var contactDetailsWireframe: ContactDetailsWireframe?
    
    var presenter: ContactsListPresenterInterface
    
    @objc init(presenter: ContactsListPresenterInterface) {
        self.presenter = presenter
        self.rootWireframe = RootWireframe()
        super.init()
    }
    
    func presentInWindow(window: UIWindow) {
        let view = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ContactListVC")
        presenter.view = view as? ContactsListViewInterface
        presenter.view!.eventHandler = presenter
        rootWireframe.showRootViewController(view, window: window)
    }
    
    func presentContactDetails(view: AnyObject) {
        contactDetailsWireframe!.presentContactDetailsViewFromViewController(view as? UIViewController)
    }
    
}
