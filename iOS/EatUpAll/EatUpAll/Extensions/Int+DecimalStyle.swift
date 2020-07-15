//
//  Int+DecimalStyle.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

extension Int {
    var moneyFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
