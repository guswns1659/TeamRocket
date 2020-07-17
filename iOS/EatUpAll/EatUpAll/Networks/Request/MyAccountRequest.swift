//
//  MyAccountRequest.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

final class MyAccountRequest: Request, Queryable {
    var path: String = EndPoint.myAccountURL
    var queryItems: [URLQueryItem] = []
    
    func append(name: QueryParameters, value: String) {
        var queryItems: [URLQueryItem] = []
        let queryItem = URLQueryItem(name: name.description, value: value)
        queryItems.append(queryItem)
        
        guard var urlComponents = URLComponents(string: path) else { return }
        urlComponents.queryItems = queryItems
        guard let urlWithQuery = urlComponents.url else { return }
        path = urlWithQuery.absoluteString
    }
}
