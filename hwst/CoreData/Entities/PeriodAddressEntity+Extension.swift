//
//  PeriodEntity+Extension.swift
//  hwst
//
//  Created by Антон Прохоров on 26.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import CoreData

extension PeriodEntity {
    func map(with periodModel: PeriodModel) {
        city = periodModel.city
        address = periodModel.address
        house = periodModel.house
        housing = periodModel.housing
        letter = periodModel.letter
        period = periodModel.period
    }
    
    class func insert(periods: [PeriodModel]) {
        var sortIndex: Int64 = 0
        periods.forEach({ periodModel  in
            if let newPeriod =  NSEntityDescription.insertNewObject(forEntityName: "PeriodEntity",
                                                                    into: Storage.shared.context) as? PeriodEntity {
                newPeriod.sortIndex = sortIndex
                newPeriod.map(with: periodModel)
                
                sortIndex += 1
            }
        })
        
        _ = Storage.shared.saveContext()
    }
    
    class func periods(limit: Int = 20, offset: Int) -> [PeriodEntity] {
        let fetchRequest: NSFetchRequest<PeriodEntity> = PeriodEntity.fetchRequest()
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(PeriodEntity.sortIndex),
                                                         ascending: true)]
        
        do {
            return try Storage.shared.context.fetch(fetchRequest)
        } catch let error as NSError {
           print("Could not fetch \(error), \(error.userInfo)")
        }

        return []
    }
    
    class func clearPeriods() -> Bool {
        if deleteData(entity: "PeriodEntity") {
            _ = Storage.shared.saveContext()
            return true
        }
        return false
    }
    
    class func deleteData(entity:String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteAllRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do { try Storage.shared.context.execute(deleteAllRequest)}
        catch { debugPrint(error); return false }
        return true
    }
}
