//
//  Storage.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import CoreData

struct Storage {
    static var shared = Storage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "hwst")
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("CoreData: Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support
    var context: NSManagedObjectContext {
        mutating get {
            return persistentContainer.viewContext
        }
    }
    
    enum SaveStatus {
        case saved, rolledBack, hasNoChanges
    }
    
    mutating func saveContext() -> SaveStatus {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return .saved
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
                
                context.rollback()
                return .rolledBack
            }
        }
        return .hasNoChanges
    }
}
