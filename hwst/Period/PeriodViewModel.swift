//
//  PeriodViewModel.swift
//  hwst
//
//  Created by Антон Прохоров on 27.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

class PeriodViewModel {
    private (set) var city = ""
    private (set) var address = ""
    private (set) var formattedHouse = ""
    private (set) var formattedPeriod = ""
    
    init(model: PeriodModel) {
        city = model.city
        address = model.address.trimmingCharacters(in: .whitespaces)
        formattedHouse = house(with: model.house, housing: model.housing, letter: model.letter)
        formattedPeriod = period(with: model.period)
    }
    
    private func house(with house: String, housing: String, letter: String) -> String {
        let houseStr = house.isEmpty ? nil : "\(GlobalStrings.house) \(house)"
        let housingStr = housing.isEmpty ? nil : "\(GlobalStrings.housing) \(housing)"
        let letterStr = letter.isEmpty ? nil : "\(GlobalStrings.letter) \(letter)"
        let houseArray = [houseStr, housingStr, letterStr]
        return houseArray.compactMap({ $0 }).joined(separator: " ")
    }
    
    private func period(with period: String) -> String {
        let periodDates = period.split(separator: "-").compactMap({ String($0).removeYearSymbol() })
        if periodDates.count == 2 {
            let startDate = periodDates[0]
            let endDate = periodDates[1]
            
            if let localStartDate = Helper.fomattedPeriodString(period: startDate),
                let localEndDate = Helper.fomattedPeriodString(period: endDate) {
                
                return localStartDate + " - " + localEndDate
            }
        }
            
        return period
    }
}
