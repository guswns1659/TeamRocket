//
//  EmptyPlateRequest.swift
//  EatUpAll
//
//  Created by delma on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

final class EmptyPlateRequest: Request {
    var path: String = EndPoint.emptyPlateDetailURL
    
    init(id: Int) {
        path += "\(id)"
    }
}
