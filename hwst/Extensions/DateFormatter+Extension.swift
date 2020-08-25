//
//  DateFormatter+Extension.swift
//  hwst
//
//  Created by Антон Прохоров on 25.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

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
