//
//  Helper.swift
//  hwst
//
//  Created by Антон Прохоров on 23.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import Foundation
import Zip

class Helper {
    static let documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last!
 
    static let zipFileURL = Helper.documentsURL.appendingPathComponent("classifier.zip")
    
    class func decodeBase64String(from base64String: String,
                                  completion: @escaping (Result<URL, Error>) -> Void) {
        
        switch base64String.saveBase64StringToZipFile(url: Helper.zipFileURL) {
        case .success(let url):
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
                debugPrint("unzip error \(error)")
                completion(Result.failure(error))
            }
        case .failure(let error):
            debugPrint(error.message)
            completion(Result.failure(error))
        }
    }
}
