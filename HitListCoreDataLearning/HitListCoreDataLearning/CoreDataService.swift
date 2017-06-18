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
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension CoreDataService {
    
    func prepareManagedObject(entityName: String) -> NSManagedObject? {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext) else {
            return nil
        }
        return NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
    }
    
    func fetchObjects(entityName: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
}

