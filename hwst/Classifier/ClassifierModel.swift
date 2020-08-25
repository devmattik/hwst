//
//  ClassifierModel.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

struct ClassifierModel: Decodable {
    let ident: Int64
    let name: String
    let file: String
    let version: String
    
    enum CodingKeys: String, CodingKey {
        case ident = "classifierId"
        case name = "classifierName"
        case file
        case version
    }
}

struct ClassifierResponseData: Decodable {
    let classifiers: [ClassifierModel]
}

struct ClassifierResponse: Decodable {
    let status: String
    let responseData: ClassifierResponseData
}
