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
    
    func start() {
        periodsService.start()
        
        periodsService.onInserItems = { [weak self] indexes, newPeriodModels in
            guard let strongSelf = self else { return }
            strongSelf.periodViewModels = newPeriodModels.map({ PeriodViewModel(model: $0) })

            let indexPaths = indexes.map({ IndexPath(row: $0, section: 0) })
            strongSelf.onInserItems?(indexPaths)
        }
        
        periodsService.onReloadAllItems = { [weak self] newPeriodModels in
            self?.periodViewModels = newPeriodModels.map({ PeriodViewModel(model: $0) })
            self?.onReloadAllItems?()
        }
        
        periodsService.onError = { [weak self] errorMessage in
            self?.onError?(errorMessage)
        }
    }
    
    func reStart() {
        periodViewModels.removeAll()
        onReloadAllItems?()
        start()
    }
    
    func loadNextPage() {
        periodsService.loadNextPage()
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
