//
//  AvatarChooserWireframe.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

class AvatarChooserWireframe: NSObject {

    var presenter: AvatarChooserPresenterInterface
    
    init(presenter:AvatarChooserPresenterInterface) {
        self.presenter = presenter
        super.init()
    }
    
    func presentAvatarChooserViewFromViewController(viewController: UIViewController) {
        let view = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("AvatarChooserVC")
        presenter.view = view as? AvatarChooserViewInterface
        presenter.view!.eventHandler = presenter
        presenter.wireframe = self
        
        viewController.navigationController?.pushViewController(view, animated: true)
    }
    
}
