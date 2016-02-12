//
//  RootWireframe.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit

@objc protocol InitialWireframeProtocol {
    func presentInWindow(window: UIWindow)
}

class RootWireframe {
    
    func showRootViewController(viewController: UIViewController, window: UIWindow) {
        let navigationController = navigationControllerFromWindow(window)
        navigationController.viewControllers = [ viewController ]
    }
    
    func navigationControllerFromWindow(window: UIWindow) -> UINavigationController {
        return window.rootViewController as? UINavigationController
    }
    
}
