//
//  ClassifierDetailViewModel.swift
//  hwst
//
//  Created by Антон Прохоров on 30.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

class ClassifierDetailViewModel {
    private let periodsService = PeriodService()
    
    var onInserItems: ((_ indexPaths: [IndexPath]) -> Void)?
    var onReloadAllItems: (() -> Void)?
    var onError: ((_ errorMessage: String) -> Void)?
    
    private var periodViewModels = [PeriodViewModel]()
    
    init() {
        periodsService.onInserItems = onInserItems
        periodsService.onError = onResultError
    }
    
    func start() {
        periodsService.start()
    }
    
    func loadNextPage() {
        periodsService.loadNextPage()
    }
    
    // Bindings
    private func onInserItems(_ indexes: [Int], _ periods: [PeriodModel], _ clearAll: Bool) -> Void {
        periodViewModels = periods.map({ PeriodViewModel(model: $0) })

        if clearAll {
            onReloadAllItems?()
        } else {
            let indexPaths = indexes.map({ IndexPath(row: $0, section: 0) })
            onInserItems?(indexPaths)
        }
    }
    
    private func onResultError(_ errorMessage: String) -> Void {
        onError?(errorMessage)
    }
    
    // MARK: Data Source
    
    func numberOfRows() -> Int {
        return periodViewModels.count
    }
    
    func item(at index: Int) -> PeriodViewModel? {
        guard index < numberOfRows() else {
            assertionFailure("Index can not be greater than numberOfItems count")
            return nil
        }
        return periodViewModels[index]
    }
}
