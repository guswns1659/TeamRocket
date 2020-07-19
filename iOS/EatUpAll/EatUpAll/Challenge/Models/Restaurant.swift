//
//  Restaurant.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/18.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct RestaurantContainer: Codable {
    let data: [Restaurant]
    let dataCount: Int
}

struct Restaurant: Codable {
    let id: Int
    let address: String
    let description: String
    let images: [String]
    let latitude: Double
    let longitude: Double
    let name: String
    let rating: Double
}
