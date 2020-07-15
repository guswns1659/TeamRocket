//
//  ChallengeEmptyPlate.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct ChallengeEmptyPlate: Codable {
    private(set) var data: [Plate]
}

struct Plate: Codable {
    private(set) var likeCount: Int
    private(set) var image: String
    private(set) var description: String
    private(set) var restaurantName: String
    private(set) var createdAt: String
    private(set) var updatedAt: String
    private(set) var latitude: Double
    private(set) var longitude: Double
}
