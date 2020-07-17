//
//  DonateRequest.swift
//  EatUpAll
//
//  Created by delma on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

final class DonateRequest: Request, Queryable {
    var path: String = EndPoint.donateURL
    var queryItems: [URLQueryItem] = []
    
    init(id: Int) {
        path += "\(id)"
    }
    
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
