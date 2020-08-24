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
