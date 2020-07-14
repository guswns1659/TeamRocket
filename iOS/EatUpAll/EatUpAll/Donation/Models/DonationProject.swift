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
    let imageURLs: DonationProjectImage
//    let numberOfDonations: Int
//    let goalAmount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "projectTitle"
        case subtitle = "titleWithCompany"
        case leftDays
        case imageURLs = "image"
        case currentAmount = "currentMoney"
//        case goalAmount
//        case numberOfDonations
    }
}

struct DonationProjectImage: Codable {
    let url: String
}
