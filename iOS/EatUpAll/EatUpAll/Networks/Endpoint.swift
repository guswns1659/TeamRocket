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
    static let totalSavingURL = "\(baseURL)account/totalSaving"
    static let donationClosingProjectURL = "\(baseURL)/project/orderByDeadLine"
    static let donationWholeProjectURL = "\(baseURL)/project/orderByCreatedAt"
    static let donationProjectDetailURL = "\(baseURL)project/"
    static let myEcoPointURL = "\(baseURL)account/ecoPoint"
    static let donateURL = "\(baseURL)project/donate/"
}

enum QueryParameters: CustomStringConvertible {
    case ecoPoint
    
    var description: String {
        switch self {
        case .ecoPoint: return "ecoPoint"
        }
    }
}
