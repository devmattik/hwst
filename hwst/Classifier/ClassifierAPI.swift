//
//  ClassifierAPI.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import Alamofire

class ClassifierAPI {
    typealias ClassifierAPIResult = Result<ClassifierModel, ClassifierAPIError>
    
    private static let urlString = "https://api.gu.spb.ru/UniversalMobileService/classifiers/downloadClassifiers?classifiersId=4"
    let url = URL(string: ClassifierAPI.urlString)!
        
    func load(completion: @escaping (ClassifierAPIResult) -> Void) {
        AF.request(url, method: .get)
            .responseDecodable(of: ClassifierResponse.self) { response in
                switch response.result {
                case .success(let classifierResponse):
                    guard let classifier = classifierResponse.responseData.classifiers.first
                    else {
                        let classifierError = ClassifierAPIError(message: Constants.isEmpty.rawValue)
                        let result = ClassifierAPIResult.failure(classifierError)
                        completion(result)
                        return
                    }
                
                    debugPrint("Received classifier with id = \(classifier.ident), name = \(classifier.name)")
                    
                    let result = ClassifierAPIResult.success(classifier)
                    completion(result)
                case .failure(let error):
                    let classifierError = ClassifierAPIError(message: Constants.serverError.rawValue, error: error)
                    let result = ClassifierAPIResult.failure(classifierError)
                    completion(result)
                }
        }
    }
    
    private enum Constants: String {
        case isEmpty = "Classifiers is Empty"
        case serverError = "Server error"
    }
}

struct ClassifierAPIError: ClassifierError {
    var message: String = "Something went wrong"
    var error: AFError? = nil
}

struct ClassifierBase64DecodeError: ClassifierError {
    var message: String = "Something went wrong"
    var error: Error? = nil
}

struct ClassifierReadDataError: ClassifierError {
    var message: String = "Something went wrong"
    var error: Error? = nil
}

protocol ClassifierError: Error {
    var message: String { get set }
}
