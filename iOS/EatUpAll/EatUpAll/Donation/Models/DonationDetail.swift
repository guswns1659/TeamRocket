//
//  DonationDetail.swift
//  EatUpAll
//
//  Created by delma on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct DonationDetail: Codable {
    private(set) var currentMoney: Int
    private(set) var mainURL: String
    private(set) var descriptionURL: [String]
    private(set) var donators: Int
    private(set) var id: Int
    private(set) var leftDay: Int
    private(set) var leftHour: Int
    private(set) var targetMoney: Int
    private(set) var title: String
    private(set) var titleWithCompany: String
}

struct MyEcoPoint: Codable {
    private(set) var ecoPoint: Int
}
