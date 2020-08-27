//
//  String+Extension.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

extension String {
    func removeYearSymbol() -> String { return self.replacingOccurrences(of: "г.", with: "") }
    
    func formatStringDate(from serverDateFormatter: DateFormatter, to localDateFormatter: DateFormatter) -> String? {
        guard let date = serverDateFormatter.date(from: self)
        else { return nil }
        
        return localDateFormatter.string(from: date).removeYearSymbol()
    }
}
