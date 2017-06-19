//
//  CoreDataService.swift
//  HitListCoreDataLearning
//
//  Created by Phetrungnapha, K. on 6/18/2560 BE.
//  Copyright © 2560 iTopStory. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    // Prevent a developer creates instance of this class.
    private init() {}
    
    // MARK: - Core Data stack
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HitListCoreDataLearning")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - My Core Data support
    
    fileprivate var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

// MARK: - select, insert, update, delete functions for Core Data

extension CoreDataService {
    
    func prepareManagedObject(entityName: String) -> NSManagedObject? {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            return nil
        }
        return NSManagedObject(entity: entity, insertInto: managedContext)
    }
    
    func fetchObjects(entityName: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteObject(entityName: String, identifier: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            objects.forEach { managedContext.delete($0) }
            saveContext()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateObject(entityName: String, identifier: String, valuesForUpdate: [String: Any]) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)
        
        do {
            if let object = try managedContext.fetch(fetchRequest).first {
                valuesForUpdate.forEach {
                    object.setValue($1, forKey: $0)
                }
                saveContext()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

