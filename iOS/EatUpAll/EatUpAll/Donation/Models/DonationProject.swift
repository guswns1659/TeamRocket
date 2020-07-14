//
//  DonationProject.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct DonationProject: Codable {
    let title: String
    let subtitle: String
    let leftDays: String
    let numberOfDonations: Int
    let currentAmount: Int
    let goalAmount: Int
    let imageDictionary: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case title = "projectTitle"
        case subtitle = "titleWithCompany"
        case leftDays
        case imageDictionary = "image"
        case currentAmount = "currentMoney"
        case goalAmount
        case numberOfDonations
    }
}
