//
//  DonationProjectDetailRequest.swift
//  EatUpAll
//
//  Created by delma on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

final class DonationProjectDetailRequest: Request {
    var path: String = EndPoint.donationProjectDetailURL
    
    init(id: Int) {
        self.path += "\(id)"
    }
}
