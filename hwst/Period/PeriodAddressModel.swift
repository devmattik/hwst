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
    
    func formattedAddress() -> String {
        let houseStr = "дом \(house)"
        let housingStr = housing.isEmpty ? "" : "корпус \(housing)"
        let letterStr = letter.isEmpty ? "" : "литер \(letter)"
        return houseStr + " " + housingStr + " " + letterStr
    }
    
    func formettedPeriod() -> String {
        let periodDates = period.split(separator: "-")
        
        guard let startDateString = periodDates.first?.replacingOccurrences(of: "г.", with: ""),
            let endDateString = periodDates.last?.replacingOccurrences(of: "г.", with: ""),
            let startDate = DateFormatter.serverDateFormat().date(from: String(startDateString)),
            let endDate = DateFormatter.serverDateFormat().date(from: String(endDateString))
        else {
            return period
        }
    
        let localStartDateString = DateFormatter.localDateFormat().string(from: startDate)
        let localEndDateString = DateFormatter.localDateFormat().string(from: endDate)
        
        return localStartDateString + "-" + localEndDateString
    }
}

extension DateFormatter {
    class func serverDateFormat() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    class func localDateFormat() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }
}
