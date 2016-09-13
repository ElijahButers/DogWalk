//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by User on 9/13/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let modelName = "Dog Walk"
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    // MARK: - Core Data stack
    
    lazy var context: NSManagedObjectContext = {
        
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    fileprivate var psc: NSPersistentStoreCoordinator {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(self.modelName)
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption : true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            print("Error adding persistnet store.")
        }
        return coordinator
    }
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    func saveContext() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                abort()
            }
        }
    }
}
