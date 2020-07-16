//
//  ChallengeEmptyPlate.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct ChallengeEmptyPlateContainer: Codable {
    let data: [ChallengeEmptyPlate]
}

struct ChallengeEmptyPlate: Codable {
    let id: Int
    let likeCount: Int
    let image: String
    let description: String
    let restaurantName: String
    let createdAt: String
    let updatedAt: String
    let latitude: Double
    let longitude: Double
    let isLiked: String
}
