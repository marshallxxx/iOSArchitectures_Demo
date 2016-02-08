//
//  AvatarCellViewModel.swift
//  Contacts
//
//  Created by Ion Brumari on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import ReactiveCocoa

public protocol AvatarCellViewModelProtocol {
    var avatarTitle: String { get }
    var avatarUrl: String { get }
}


public final class AvatarCellViewModel: NSObject, AvatarCellViewModelProtocol {
    
    public let avatarTitle: String
    public var avatarUrl: String
    
    
    init(avatar: Avatar) {
        avatarTitle = avatar.title!
        avatarUrl = avatar.url!
        
        super.init()
    }
}
