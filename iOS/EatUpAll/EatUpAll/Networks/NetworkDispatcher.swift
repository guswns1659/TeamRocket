//
//  NetworkDispatcher.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func execute(request: URLRequest, handler: @escaping (Result<Data?, Error>) -> Void)
}
