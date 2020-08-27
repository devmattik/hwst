//
//  PeriodModel.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

struct PeriodModel: Decodable, Equatable {
    let city, address, house, housing, letter, period: String
    
    enum CodingKeys: String, CodingKey {
        case city = "Населенный пункт"
        case address = "Адрес жилого здания"
        case house = "№ дома"
        case housing = "корпус"
        case letter = "литер"
        case period = "Период отключения ГВС"
    }
    
    init(from entity: PeriodEntity) {
        city = entity.city ?? ""
        address = entity.address ?? ""
        house = entity.house ?? ""
        housing = entity.housing ?? ""
        letter = entity.letter ?? ""
        period = entity.period ?? ""
    }
}
