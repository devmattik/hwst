//
//  ClassifierError.swift
//  hwst
//
//  Created by Антон Прохоров on 26.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import Alamofire

class ClassifierError: Error {
    let message: String
    let error: Error?
    
    init(message: String, error: Error? = nil) {
        self.message = message
        self.error = error
    }
}
