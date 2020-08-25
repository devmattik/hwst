//
//  PeriodAddressModel.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

struct PeriodAddressModel: Decodable, Equatable {
    let city, address, house, housing, letter, period: String
    
    enum CodingKeys: String, CodingKey {
        case city = "Населенный пункт"
        case address = "Адрес жилого здания"
        case house = "№ дома"
        case housing = "корпус"
        case letter = "литер"
        case period = "Период отключения ГВС"
    }
    
    init(from entity: PeriodAddressEntity) {
        city = entity.city ?? ""
        address = entity.address ?? ""
        house = entity.house ?? ""
        housing = entity.housing ?? ""
        letter = entity.letter ?? ""
        period = entity.period ?? ""
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(String.self, forKey: .city)
        address = try values.decode(String.self, forKey: .address)
        house = try values.decode(String.self, forKey: .house)
        housing = try values.decode(String.self, forKey: .housing)
        letter = try values.decode(String.self, forKey: .letter)

        period = try values.decode(String.self, forKey: .period)
    }
}

extension PeriodAddressModel {
    func formattedAddress() -> String {
        address.trimmingCharacters(in: .whitespaces)
    }
    
    func formattedHouse() -> String {
        let houseStr = "дом \(house)"
        let housingStr = housing.isEmpty ? "" : "корпус \(housing)"
        let letterStr = letter.isEmpty ? "" : "литер \(letter)"
        return houseStr + " " + housingStr + " " + letterStr
    }
    
    func formattedPeriod() -> String {
        let periodDates = period.split(separator: "-").compactMap({ String($0).removeYearSymbol() })
        if periodDates.count == 2 {
            let startDate = periodDates[0]
            let endDate = periodDates[1]
            if let localStartDate = startDate.serverToLocalDate(),
                let localEndDate = endDate.serverToLocalDate() {
                
                return localStartDate + " - " + localEndDate
            }
        }
            
        return period
    }
}
