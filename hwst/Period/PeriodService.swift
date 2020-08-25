//
//  PeriodService.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

class PeriodService {
    
    private let classifierService = ClassifierService()
    private let periodAPI = PeriodAPI()
    
    private var periodAddresses = [PeriodAddressModel](){
        didSet {
            onUpdatePeriodAdresses()
        }
    }
    
    private let limit = 20
    private var currentOffset = 0
    private var isFetching = false
    
    var onInserItems: ((_ indexes: [Int]) -> Void)?
    var onReloadAllItems: (() -> Void)?
    var onError: ((_ errorMessage: String) -> Void)?
    
    func start() {
        loadClassifier()
    }
    
    func reStart() {
        currentOffset = 0
        periodAddresses.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.onReloadAllItems?()
        }
        
        start()
    }
    
    func loadNextPage() {
        guard !isFetching, !periodAddresses.isEmpty else { return }
        loadPage()
    }
    
    private func loadClassifier() {
        classifierService.load() { [weak self] result in
            switch result {
            case .success(let url):
                self?.load(url: url)
            case .failure(let error):
                debugPrint(error)
                self?.onError?("Не удалось получить данные")
                self?.loadPage()
            }
        }
    }
    
    private func load(url: URL) {
        currentOffset = 0
        periodAPI.loadPeriods(from: url) { [weak self] result in
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
    
    private func loadPage() {
        isFetching = true
        
        let savedPeriods = CoreDataManager.shared.periods(limit: limit, offset: currentOffset)
        if !savedPeriods.isEmpty {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                    let periodAdressesModels = savedPeriods.map { PeriodAddressModel(from: $0) }
                    strongSelf.periodAddresses.append(contentsOf: periodAdressesModels)
                    strongSelf.currentOffset += strongSelf.limit
                strongSelf.isFetching = false
            }
        } else {
            isFetching = false
        }
    }
    
    private func onUpdatePeriodAdresses() {
        let currentCount = periodAddresses.count - limit
        let indexes = currentCount > 0
            ? Array(currentCount ..< periodAddresses.count)
            : Array(0 ..< periodAddresses.count)
        if !indexes.isEmpty {
            onInserItems?(indexes)
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
