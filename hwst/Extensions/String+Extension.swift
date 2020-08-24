//
//  String+Extension.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation

extension String {
    func decodeToZipFile(url: URL) -> Result<URL, ClassifierBase64DecodeError> {
        guard let convertedData = Data(base64Encoded: self)
        else {
            let message = "Converting data error"
            return Result.failure(ClassifierBase64DecodeError(message: message))
        }

        do {
            try convertedData.write(to: url)
        } catch {
            let message = "Writing data to file error"
            return Result.failure(ClassifierBase64DecodeError(message: message, error: error))
        }
        
        return Result.success(url)
    }
}
