//
//  NetworkError.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case NotFound
    case BadRequest
    
    var description: String {
        switch self {
        case .NotFound:
            return "네트워크 요청에 실패했습니다."
        case .BadRequest:
            return "잘못된 요청입니다."
        }
    }
}

enum DecodingError: Error, CustomStringConvertible {
    
    case DecodeError
    
    var description: String {
        switch self {
        case .DecodeError:
            return "네트워크 요청에 실패했습니다."
        }
    }
}
