//
//  TodayRecord.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct TodayRecord: Codable {
    private(set) var todayTotalPlates: Int
    private(set) var todayTotalSaving: Double
    private(set) var todayMyPlates: Int
    private(set) var todayMySaving: Double
}
