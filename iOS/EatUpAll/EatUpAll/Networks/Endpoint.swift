//
//  Endpoint.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

enum EndPoint {
    static let baseURL = "http://15.164.255.212/api/"
    static let emptyPlateURL = "\(baseURL)challenge/weeklyTopLike"
    static let todayRecordURL = "\(baseURL)account/todaySaving"
}
