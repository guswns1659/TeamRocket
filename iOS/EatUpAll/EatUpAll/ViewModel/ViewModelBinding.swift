//
//  ViewModelBinding.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Key
    typealias Handler = (Key) -> Void
    func updateNotify(handler: @escaping Handler)
}
