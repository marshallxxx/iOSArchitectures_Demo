//
//  ContactMVC.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/4/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation

class ContactMVC: NSObject, ModelConvertorProtocol {
    var phoneNumber: String?
    var avatarURL: String?
    var nickname: String?
    
    required override init() {
        super.init()
    }
}
