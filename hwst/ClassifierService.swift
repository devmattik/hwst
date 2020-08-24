//
//  ClassifierService.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import Zip

class ClassifierService {
    
    private let api = ClassifierAPI()
    
    func load(completion: @escaping (Result<URL, Error>) -> Void) {
        api.load { [weak self] result in
            switch result {
            case .success(let classifier):
                self?.decodeToZip(from: classifier.file, completion: completion)
            case .failure(let error):
                debugPrint("Failed with message \(error.message) error: \(error.error?.localizedDescription ?? "nil")")
                completion(Result.failure(error))
            }
        }
    }
    
    func decodeToZip(from base64String: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let zipFileURL = Helper.zipFileURL
        debugPrint(zipFileURL)
        
        switch base64String.decodeToZipFile(url: zipFileURL) {
        case .success(let url):
            var fileURL: URL!
            
            do {
                try Zip
                    .unzipFile(url,
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
                debugPrint("unzip error \(error)")
                completion(Result.failure(error))
            }
        case .failure(let error):
            debugPrint(error.message)
            completion(Result.failure(error))
        }
    }
}
