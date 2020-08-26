//
//  Helper.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

class Helper {
    static let documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last!
 
    static let zipFileURL = Helper.documentsURL.appendingPathComponent("classifier.zip")
}
