//
//  DonationProject.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct DonationProjectContainer: Codable {
    let data: [DonationProject]
}

struct DonationProject: Codable {
    let id: Int
    let title: String
    let subtitle: String
    let leftDays: Int
    let currentAmount: Int
    let goalAmount: Int
    let imageURLs: [String]
    let numberOfDonations: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "projectTitle"
        case subtitle = "titleWithCompany"
        case leftDays
        case imageURLs = "images"
        case currentAmount = "currentMoney"
        case goalAmount = "targetMoney"
        case numberOfDonations = "donators"
    }
}
