//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var contactID:Int
    @NSManaged var phoneNumber: String?
    @NSManaged var avatarURL: String?
    @NSManaged var nickname: String?

}
