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
    func newContact() -> Contact
    func removeContactWithID(contactID: Int) -> Bool
    func getAllContacts() -> [Contact]?
    func getContactWithID(contactID:Int) -> Contact?
    func updateContact(contact:Contact) -> Bool
    func getContacts(contactKey:String, contactValue:String) -> [Contact]?
}

class CoreDataManager: PersistenStoreProtocol {
    
    // MARK: CoreData Entities
    
    let entity_Contacts = "Contact"
    
    
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
    
    // MARK: - Core Data Methods
    
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
    
    func removeContactWithID(contactID: Int) -> Bool {
        if let contact = getContactWithID(contactID) {
            managedObjectContext.deleteObject(contact)
            saveContext()
            return true
        } else {
            return false
        }
    }
    
    func newContact() -> Contact {
        
        let id = newContactId()
        
        let contact = NSEntityDescription.insertNewObjectForEntityForName(entity_Contacts, inManagedObjectContext: managedObjectContext) as! Contact
        
        contact.contactID = id
        
        return contact
    }
    
    private func newContactId() -> Int {
        let request = NSFetchRequest(entityName: entity_Contacts)
        
        request.predicate = NSPredicate(format: "contactID = max:(contactID)")

        do {
            let response = try managedObjectContext.executeFetchRequest(request) as? [Contact]
            return (response?.count > 0 ? response![0].contactID : 0) + 1
        } catch {
            return -1
        }
    }
    
    func getAllContacts() -> [Contact]? {
        
        let request = NSFetchRequest(entityName: entity_Contacts)
        
        do {
            return try managedObjectContext.executeFetchRequest(request) as? [Contact]
        } catch {
            return nil
        }
    }
    
    func getContactWithID(contactID:Int) -> Contact? {
        let request = NSFetchRequest(entityName: entity_Contacts)
        
        request.predicate = NSPredicate(format: "contactID = %i", contactID)
        
        var allContacts:[Contact]?
        
        do {
            allContacts = try managedObjectContext.executeFetchRequest(request) as? [Contact]
        } catch {
            return nil
        }
        
        return allContacts?.count > 0 ? allContacts![0] : nil
    }
    
    func updateContact(contact:Contact) -> Bool {
        if let contactToUpdate = getContactWithID(contact.contactID) {
            
            contactToUpdate.nickname = contact.nickname;
            contactToUpdate.phoneNumber = contact.phoneNumber
            contactToUpdate.avatarURL = contact.avatarURL
            
            saveContext()
            
            return true
        } else {
            return false
        }
    }
    
    func getContacts(contactKey:String, contactValue:String) -> [Contact]? {
        let request = NSFetchRequest(entityName: entity_Contacts)
        
        request.predicate = NSPredicate(format: "%@==%@", contactKey, contactValue)
        
        var allContacts:[Contact]?
        
        do {
            allContacts = try managedObjectContext.executeFetchRequest(request) as! [Contact]
        } catch {
            return nil
        }
        
        return allContacts
    }
    
}
