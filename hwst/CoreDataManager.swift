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
    
    private func deleteData(entity:String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteAllRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do { try Storage.shared.context.execute(deleteAllRequest)}
        catch { debugPrint(error); return false }
        return true
    }
    
    func insert(periods: [PeriodAddressModel]) {
        periods.forEach({ periodAddress  in
            if let newPeriod =  NSEntityDescription.insertNewObject(forEntityName: "PeriodAddressEntity",
                                                                    into: Storage.shared.context) as? PeriodAddressEntity {
                
                newPeriod.map(with: periodAddress)
            }
        })
        
        saveContext()
    }
    
    func periods(limit: Int = 20, offset: Int) -> [PeriodAddressEntity] {
        let fetchRequest: NSFetchRequest<PeriodAddressEntity> = PeriodAddressEntity.fetchRequest()
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        
        do {
            return try Storage.shared.context.fetch(fetchRequest)
        } catch let error as NSError {
           print("Could not fetch \(error), \(error.userInfo)")
        }

        return []
    }
    
    func clearPeriods() -> Bool {
        if deleteData(entity: "PeriodAddressEntity"){
            self.saveContext()
            return true
        }
        return false
    }
}

extension PeriodAddressEntity {
    func map(with periodAddress: PeriodAddressModel) {
        city = periodAddress.city
        address = periodAddress.address
        house = periodAddress.house
        housing = periodAddress.housing
        letter = periodAddress.letter
        period = periodAddress.period
    }
}
