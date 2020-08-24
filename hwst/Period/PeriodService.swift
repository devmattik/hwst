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
    
    private var periodAddresses = [PeriodAddressModel](){
        didSet {
            let currentCount = periodAddresses.count - limit
            let indexes = currentCount > 0
                ? Array(currentCount ..< periodAddresses.count)
                : Array(0 ..< periodAddresses.count)
            if !indexes.isEmpty {
                onInserItems?(indexes)
            }
        }
    }
    
    private let limit = 20
    private var currentOffset = 0
    
    private var isFetching = false
    
    var onInserItems: ((_ indexes: [Int]) -> Void)?
    
    /// Initial load
    /// - Parameter url: Url for load data
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
    
    /// Load current page from Database
    /// Used for infinity scroll
    func loadPage() {
        guard !isFetching else { return }
        isFetching = true
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let savedPeriods = CoreDataManager.shared
                                .periods(limit: strongSelf.limit,
                                         offset: strongSelf.currentOffset)
            
            let periodAdressesModels = savedPeriods.map { PeriodAddressModel(from: $0) }
            strongSelf.periodAddresses.append(contentsOf: periodAdressesModels)
            strongSelf.currentOffset += strongSelf.limit
            strongSelf.isFetching = false
        }
    }
    
    private func savePeriods(_ periods: [PeriodAddressModel]) {
        debugPrint("Save periods count ", periods.count)
        _ = CoreDataManager.shared.clearPeriods()
        CoreDataManager.shared.insert(periods: periods)
    }
}

// PeriodService Data Source
extension PeriodService {
    func numberOfItems() -> Int {
        return periodAddresses.count
    }
    
    func item(at index: Int) -> PeriodAddressModel? {
        guard index < numberOfItems() else {
            assertionFailure("Index can not be greater than numberOfItems count")
            return nil
        }
        return periodAddresses[index]
    }
}
