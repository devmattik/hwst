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
    private let fileDecoderService = FileDecoderService()
    
    func load(completion: @escaping (Result<URL, ClassifierError>) -> Void) {
        classifierAPI.load { [weak self] result in
            switch result {
            case .success(let classifier):
                self?.fileDecoderService.decode(classifier.file) { decoderResult in
                    completion(
                        decoderResult.mapError({
                            ClassifierError(message: $0.message, error: $0.error)
                        })
                    )
                }
            case .failure(let error):
                debugPrint("Failed with message \(error.message) error: \(error.error?.localizedDescription ?? "nil")")
                completion(Result.failure(error))
            }
        }
    }
}
