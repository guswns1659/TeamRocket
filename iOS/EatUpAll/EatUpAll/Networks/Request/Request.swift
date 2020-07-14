//
//  Request.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var bodyParams: Data? { get }
    func asURLRequest() -> URLRequest
}

extension Request {
    var method: HTTPMethod { return .GET }
    var headers: HTTPHeaders? { return nil }
    var bodyParams: Data? { return nil }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = self.method.rawValue
        guard let bodyParameter = bodyParams else { return request }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = bodyParameter
        return request
    }
}
