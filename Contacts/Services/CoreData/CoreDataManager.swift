//
//  CoreDataManager.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import Foundation
import CoreData

protocol PersistenStoreProtocol {
    func saveContext ()
    func removeContactWithPhoneNumber(phoneNumber: String) -> Bool
    func newContact() -> Contact
    func getAllContacts() -> [Contact]?
    func getContactWithPhoneNumber(phoneNumber:String) -> Contact?
    func checkIfPhoneNumberIsFree(phoneNumber:String) -> Bool
}

class CoreDataManager {
    
    // MARK: CoreData Entities
    
    let entity_Contacts = "Contacts"
    
    
    // MARK: - Core Data stack
    
    lazy private var applicationDocumentsDirectory: NSURL = {
               let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy private var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Contacts", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy private var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy private var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func removeContactWithPhoneNumber(phoneNumber: String) -> Bool {
        if let contact = getContactWithPhoneNumber(phoneNumber) {
            managedObjectContext.deleteObject(contact)
            return true
        } else {
            return false
        }
    }
    
    func newContact() -> Contact {
        return NSEntityDescription.insertNewObjectForEntityForName(entity_Contacts, inManagedObjectContext: managedObjectContext) as! Contact
    }
    
    func getAllContacts() -> [Contact]? {
        
        let request = NSFetchRequest(entityName: entity_Contacts)
        
        do {
            return try managedObjectContext.executeFetchRequest(request) as? [Contact]
        } catch {
            return nil
        }
    }
    
    func getContactWithPhoneNumber(phoneNumber:String) -> Contact? {
        let request = NSFetchRequest(entityName: entity_Contacts)
        
        request.predicate = NSPredicate(format: "phoneNumber = %@", phoneNumber)
        
        var allContacts:[Contact]?
        
        do {
            allContacts = try managedObjectContext.executeFetchRequest(request) as? [Contact]
        } catch {
            return nil
        }
        
        return allContacts?.count > 0 ? allContacts![0] : nil
    }
    
    func checkIfPhoneNumberIsFree(phoneNumber:String) -> Bool {
        return getContactWithPhoneNumber(phoneNumber) == nil
    }
    
}
