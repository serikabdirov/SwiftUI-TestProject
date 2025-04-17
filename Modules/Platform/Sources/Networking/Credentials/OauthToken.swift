//
//  OauthToken.swift
//  Platform
//
//  Created by Zart Arn on 30.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public typealias Token = OauthToken

public struct OauthToken: Codable, Equatable {
    public let accessToken: String
    public let refreshToken: String
    
    func isValid() -> Bool {
        // TODO: we can use expireDate for this
        return true
    }

    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
    }
}
