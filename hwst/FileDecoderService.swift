//
//  FileDecoderService.swift
//  hwst
//
//  Created by Антон Прохоров on 26.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import Zip

class FileDecoderService {
            
    func decode(_ base64string:String, completion: @escaping (Result<URL, ClassifierError>) -> Void) {
        
        let saveToFileResult = save(base64String: base64string, toFile: Helper.zipFileURL)
        switch saveToFileResult {
        case .success(let url):
            unzipFile(with: url, completion: completion)
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
    
    private func save(base64String: String, toFile url: URL) -> Result<URL, ClassifierError> {
        guard let convertedData = Data(base64Encoded: base64String)
        else {
            return Result.failure(ClassifierError(message: GlobalStrings.convertedDataErrorMessage))
        }

        do {
            try convertedData.write(to: url)
        } catch {
            return Result.failure(ClassifierError(message: GlobalStrings.writeToFileErrorMessage, error: error))
        }
        
        return Result.success(url)
    }
    
    private func unzipFile(with url: URL, completion: @escaping (Result<URL, ClassifierError>) -> Void) {
        var fileURL: URL!
        do {
            try Zip.unzipFile(url,
                              destination: Helper.documentsURL,
                              overwrite: true,
                              password: nil,
                              progress: { value -> () in
                                if value == 1 {
                                    completion(Result.success(fileURL))
                                }
                              },
                              fileOutputHandler: { fileOutpuURL in
                                debugPrint(fileOutpuURL)
                                fileURL = fileOutpuURL
                              })
        } catch {
            completion(Result.failure(ClassifierError(message: GlobalStrings.unzipFileErrorMessage,
                                                              error: error)))
        }
    }
}
