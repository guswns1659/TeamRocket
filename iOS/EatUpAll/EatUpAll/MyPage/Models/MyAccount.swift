//
//  MyAccount.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct MyAccount: Codable {
    private(set) var ecoPoint: Int
    private(set) var id: Int
    private(set) var name: String
    private(set) var profileUrl: String
}
