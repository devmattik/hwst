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
    
    private var periodModels = [PeriodModel](){
        didSet {
            onUpdatePeriodModels()
        }
    }
    
    private let limit = 20
    private var currentOffset = 0
    private var isFetching = false
    private var needsClearAll = true
    
    var onInserItems: ((_ indexes: [Int], _ periods: [PeriodModel], _ clearAll: Bool) -> Void)?
    var onError: ((_ errorMessage: String) -> Void)?
    
    func start() {
        currentOffset = 0
        needsClearAll = true
        loadClassifier()
    }
    
    func loadNextPage() {
        guard !isFetching, !periodModels.isEmpty else { return }
        fetchPeriods()
    }
    
    private func loadClassifier() {
        classifierService.load() { [weak self] result in
            switch result {
            case .success(let url):
                self?.periodModels.removeAll()
                self?.load(url: url)
            case .failure(let error):
                debugPrint(error)
                self?.onError?(GlobalStrings.dataErrorMessage)
                self?.fetchPeriods()
            }
        }
    }
    
    private func load(url: URL) {
        currentOffset = 0
        periodAPI.loadPeriods(from: url) { [weak self] result in
            switch result {
            case .success(let periods):
                if periods != self?.periodModels {
                    self?.savePeriods(periods)
                }
            case .failure(let error):
                debugPrint(error)
            }
            
            self?.fetchPeriods()
        }
    }
    
    private func fetchPeriods() {
        isFetching = true
        
        let savedPeriods = PeriodEntity.periods(limit: limit,
                                                offset: currentOffset)
            
        if !savedPeriods.isEmpty {
            let savedPeriodModels = savedPeriods.map { PeriodModel(from: $0) }
            periodModels.append(contentsOf: savedPeriodModels)
            currentOffset += limit
        }
        isFetching = false
    }
    
    private func onUpdatePeriodModels() {
        let currentCount = periodModels.count - limit
        let indexes = currentCount > 0
            ? Array(currentCount ..< periodModels.count)
            : Array(0 ..< periodModels.count)
        if !indexes.isEmpty {
            onInserItems?(indexes, periodModels, needsClearAll)
        }
    }
    
    private func savePeriods(_ periods: [PeriodModel]) {
        debugPrint("Save periods count ", periods.count)
        _ = PeriodEntity.clearPeriods()
        PeriodEntity.insert(periods: periods)
    }
}
