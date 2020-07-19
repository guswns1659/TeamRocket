//
//  ChallengeNewPostRequest.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import Foundation

struct ChallengeUploadRequest: Request {
    var path: String = EndPoint.challengeUploadURL
    var method: HTTPMethod = .POST
}
