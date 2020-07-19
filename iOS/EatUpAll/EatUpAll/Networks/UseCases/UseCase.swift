//
//  UseCase.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation
protocol UseCase {
    var networkDispatcher: NetworkDispatcher { get set }
    
    func getResources<T: Codable>(
        request: URLRequest,
        dataType: T.Type,
        completion: @escaping (Result<T, Error>) -> ())
    func getStatus(request: URLRequest, completion: @escaping (Result<Any, NetworkError>) -> ())
}

extension UseCase {
    func getResources<T: Codable>(
        request: URLRequest,
        dataType: T.Type,
        completion: @escaping (Result<T, Error>) -> ()) {
        networkDispatcher.execute(request: request) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let decodedData = try? JSONDecoder().decode(dataType, from: data) else {
                    completion(.failure(DecodingError.DecodeError))
                    return
                }
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getStatus(request: URLRequest, completion: @escaping (Result<Any, NetworkError>) -> ()) {
        networkDispatcher.implement(request: request) { statusCode in
            switch statusCode {
            case 200...202:
                return completion(.success(true))
            default:
                return completion(.failure(.BadRequest))
            }
        }
    }
}
