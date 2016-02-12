//
//  ContactCellViewModel.swift
//  Contacts
//
//  Created by Ion Brumari on 2/5/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import ReactiveCocoa

public protocol ContactCellViewModelProtocol {
    var contactName: String { get }
    var contactPhone: String { get }
    var contactAvatar: String? { get }
}


public final class ContactCellViewModel: NSObject, ContactCellViewModelProtocol {
    
    public let contactName: String
    public var contactPhone: String
    public let contactAvatar: String?

    
    init(contact: ContactMVVM) {
        contactName = contact.nickname!
        contactPhone = contact.phoneNumber!
        contactAvatar = contact.avatarURL
        
        super.init()
    }
}
