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
    static let weeklyTopLikedEmptyPlateURL = "\(baseURL)challenge/weeklyTopLike"
    static let emptyPlateDetailURL = "\(baseURL)challenge/"
    static let likeURL = "\(baseURL)challenge/like/"
    static let allEmptyPlateURL = "\(baseURL)challenge/all"
    static let todayRecordURL = "\(baseURL)account/todaySaving"
    static let totalSavingURL = "\(baseURL)account/totalSaving"
    static let donationClosingProjectURL = "\(baseURL)/project/orderByDeadLine"
    static let donationWholeProjectURL = "\(baseURL)/project/orderByCreatedAt"
    static let donationProjectDetailURL = "\(baseURL)project/"
    static let myEcoPointURL = "\(baseURL)account/ecoPoint"
    static let donateURL = "\(baseURL)project/donate/"
    static let challengeUploadURL = "\(baseURL)/challenge/upload"
    static let restaurantInfoURL = "\(baseURL)/restaurant/"
}

enum QueryParameters: CustomStringConvertible {
    case ecoPoint
    case liked
    
    var description: String {
        switch self {
        case .ecoPoint: return "ecoPoint"
        case .liked: return "liked"
        }
    }
}
