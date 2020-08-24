//
//  PeriodService.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

class PeriodService: NSObject {
    
    private let api = PeriodAPI()
    
    var onUpdatePeriods: (([Int]) -> Void)?
    
    var periodAddresses = [PeriodAddressModel](){
        didSet {
            debugPrint("didSet work")
            let currentCount = periodAddresses.count - limit
            debugPrint("currentCount ", currentCount)
            let indexes = currentCount > 0
                ? Array(currentCount ..< periodAddresses.count)
                : Array(0 ..< periodAddresses.count)
            
            debugPrint("indexes ", indexes)
            if !indexes.isEmpty {
                onUpdatePeriods?(indexes)
            }
        }
    }
    
    let limit = 20
    var currentOffset = 0
    
    func load(url: URL) {
        currentOffset = 0
        api.loadPeriods(from: url) { [weak self] result in
            switch result {
            case .success(let periods):
                if periods != self?.periodAddresses {
                    self?.savePeriods(periods)
                }
            case .failure(let error):
                debugPrint(error)
            }
            
            self?.loadPage()
        }
    }
    
    func loadPage() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            // Load saved data from CoreData always
            let savedPeriods = CoreDataManager.shared.periods(limit: strongSelf.limit, offset: strongSelf.currentOffset)
            let periodAdressesModels = savedPeriods.map { PeriodAddressModel(from: $0) }
            strongSelf.periodAddresses.append(contentsOf: periodAdressesModels)
            strongSelf.currentOffset += strongSelf.limit
        }
    }
    
    private func savePeriods(_ periods: [PeriodAddressModel]) {
        _ = CoreDataManager.shared.clearPeriods()
        CoreDataManager.shared.insert(periods: periods)
    }
}
