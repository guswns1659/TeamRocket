//
//  PointHistory.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct PointHistory: Codable {
    private(set) var createdAt: String
    private(set) var ecoPoint: Int
    private(set) var pointOption: String
    private(set) var projectName: String?
}
