//
//  Session+NetworkDispatcher.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation
import Alamofire

extension Session {
    func execute(request: URLRequest, handler: @escaping (Result<Data?, Error>) -> Void) {
        self.request(request).validate().response { response in
            switch response.result {
            case .success(let data):
                handler(.success(data))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
