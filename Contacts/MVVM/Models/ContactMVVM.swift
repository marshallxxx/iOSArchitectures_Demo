//
//  ContactMVVM.swift
//  Contacts
//
//  Created by Ion Brumari on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactMVVM: NSObject, ModelConvertorProtocol {
    
    var contactID: Int
    var phoneNumber: String?
    var avatarURL: String?
    var nickname: String?
    
    required override init() {
        contactID = -1
        super.init()
    }
}
