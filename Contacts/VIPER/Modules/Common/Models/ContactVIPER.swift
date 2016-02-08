//
//  ContactVIPER.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/8/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactVIPER: NSObject, ModelConvertorProtocol {
    var contactID: Int
    var phoneNumber: String?
    var avatarURL: String?
    var nickname: String?
    
    override required init() {
        self.contactID = -1
        super.init()
    }
}
