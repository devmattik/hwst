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
    typealias ClassifierAPIResult = Result<ClassifierModel, ClassifierError>
    
    private static let urlString = "https://api.gu.spb.ru/UniversalMobileService/classifiers/downloadClassifiers?classifiersId=4"
    let url = URL(string: ClassifierAPI.urlString)!
        
    func load(completion: @escaping (Result<ClassifierModel, ClassifierError>) -> Void) {
        AF.request(url, method: .get)
            .responseDecodable(of: ClassifierResponse.self) { response in
                switch response.result {
                case .success(let classifierResponse):
                    guard let classifier = classifierResponse.responseData.classifiers.first
                    else {
                        let classifierError = ClassifierError(message: GlobalStrings.emptyClassifier)
                        let result = ClassifierAPIResult.failure(classifierError)
                        completion(result)
                        return
                    }
                
                    debugPrint("Received classifier with id = \(classifier.ident), name = \(classifier.name)")
                    
                    let result = ClassifierAPIResult.success(classifier)
                    completion(result)
                case .failure(let error):
                    let classifierError = ClassifierError(message: GlobalStrings.serverError, error: error)
                    let result = ClassifierAPIResult.failure(classifierError)
                    completion(result)
                }
        }
    }
}
