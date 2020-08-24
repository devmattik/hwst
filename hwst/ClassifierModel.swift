//
//  ClassifierModel.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

struct ClassifierModel: Decodable {
    let ident: Int
    let name: String
    let file: String
    
    enum CodingKeys: String, CodingKey {
        case ident = "classifierId"
        case name = "classifierName"
        case file
    }
}
struct ClassifierResponseData: Decodable {
    let classifiers: [ClassifierModel]
}
struct ClassifierResponse: Decodable {
    let status: String
    let responseData: ClassifierResponseData
}
