//
//  PeriodAddressEntity+Extension.swift
//  hwst
//
//  Created by Антон Прохоров on 26.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import CoreData

extension PeriodAddressEntity {
    func map(with periodAddress: PeriodAddressModel) {
        city = periodAddress.city
        address = periodAddress.address
        house = periodAddress.house
        housing = periodAddress.housing
        letter = periodAddress.letter
        period = periodAddress.period
    }
    
    class func insert(periods: [PeriodAddressModel]) {
        var sortIndex: Int64 = 0
        periods.forEach({ periodAddress  in
            if let newPeriod =  NSEntityDescription.insertNewObject(forEntityName: "PeriodAddressEntity",
                                                                    into: Storage.shared.context) as? PeriodAddressEntity {
                newPeriod.sortIndex = sortIndex
                newPeriod.map(with: periodAddress)
                
                sortIndex += 1
            }
        })
        
        _ = Storage.shared.saveContext()
    }
    
    class func periods(limit: Int = 20, offset: Int) -> [PeriodAddressEntity] {
        let fetchRequest: NSFetchRequest<PeriodAddressEntity> = PeriodAddressEntity.fetchRequest()
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(PeriodAddressEntity.sortIndex),
                                                         ascending: true)]
        
        do {
            return try Storage.shared.context.fetch(fetchRequest)
        } catch let error as NSError {
           print("Could not fetch \(error), \(error.userInfo)")
        }

        return []
    }
    
    class func clearPeriods() -> Bool {
        if deleteData(entity: "PeriodAddressEntity") {
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
