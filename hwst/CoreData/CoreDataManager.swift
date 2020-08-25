//
//  CoreDataManager.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func saveContext() {
        do {
            try Storage.shared.context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteData(entity:String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteAllRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do { try Storage.shared.context.execute(deleteAllRequest)}
        catch { debugPrint(error); return false }
        return true
    }
}
