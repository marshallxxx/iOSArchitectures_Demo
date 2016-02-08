//
//  AvatarChooserModuleInterface.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

@objc protocol AvatarChooserViewInterface {
    var eventHandler: AvatarChooserPresenterInterface? { get set }
}

@objc protocol AvatarChooserPresenterInterface {
    weak var view: AvatarChooserViewInterface? { get set }
    weak var wireframe: AvatarChooserWireframe? { get set }
}