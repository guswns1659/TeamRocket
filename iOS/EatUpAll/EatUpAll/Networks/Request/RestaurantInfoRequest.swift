//
//  RestaurantInfoRequest.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/18.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct RestaurantInfoRequest: Request {
    var path: String = EndPoint.restaurantInfoURL
    
    init(restaurantID: Int) {
        path = "\(path)/\(restaurantID)"
    }
}
