//
//  ChallengeNewPostUseCase.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation
import Alamofire

struct ChallengeNewPostUseCase: UseCase {
    var networkDispatcher: NetworkDispatcher = AF
    
    func upload(
        request: Alamofire.URLRequestConvertible,
        imageData : Data,
        parameters: [String: Any]) {
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data"
        ]
        
        let url = URL(string: EndPoint.challengeUploadURL)!
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            multiPart.append(imageData, withName: "file", fileName: "file.jpeg", mimeType: "picture/jpeg")
        }, to: url, method: .post, headers: headers)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    print(data)
                    do {
                        let response = try JSONDecoder().decode(UploadResponse.self, from: data)
                        print(response)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}

struct UploadResponse: Decodable {
    let status: String
}
