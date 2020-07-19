//
//  MyAccountRequest.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

final class MyAccountRequest: Request {
    var path: String = EndPoint.myAccountURL
    
    init(id: Int) {
        path += "\(id)"
    }
}
