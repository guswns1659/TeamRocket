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
    let deadline: Date
    let numberOfDonations: Int
    let currentAmount: Int
    let goalAmount: Int
}
