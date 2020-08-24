//
//  PeriodsAPI.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import Alamofire

class PeriodsAPI {
    
    func loadPeriods(from filePath: URL, completion: @escaping (Result<[PeriodAddressModel], AFError>) -> Void) {
        let url = URL(fileURLWithPath: filePath.absoluteString)

        AF.request(url, method: .get)
        .responseDecodable(of: [PeriodAddressModel].self) { response in
            completion(response.result)
        }
    }
}
