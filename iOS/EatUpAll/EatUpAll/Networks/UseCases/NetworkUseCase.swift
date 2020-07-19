//
//  NetworkUseCase.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/18.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkUseCase: UseCase {
    var networkDispatcher: NetworkDispatcher = AF
}
