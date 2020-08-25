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
    
    private let classifierAPI = ClassifierAPI()
    
    func load(completion: @escaping (Result<URL, Error>) -> Void) {
        classifierAPI.load { result in
            switch result {
            case .success(let classifier):
                Helper.decodeBase64String(from: classifier.file, completion: completion)
            case .failure(let error):
                debugPrint("Failed with message \(error.message) error: \(error.error?.localizedDescription ?? "nil")")
                completion(Result.failure(error))
            }
        }
    }
}
