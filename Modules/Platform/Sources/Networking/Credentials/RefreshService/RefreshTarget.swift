//
//  RefreshTarget.swift
//  Platform
//
//  Created by Zart Arn on 30.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Networking

enum RefreshTarget {
    static func refreshToken(_ token: String) -> BallTargetModel {
        return BallTargetModel(
            path: "/api/auth/token/refresh/",
            method: .post,
            parameters: .requestParameters(
                parameters: ["refresh": token],
                encoding: JSONEncoding()
            ),
            shouldAuthorize: false
        )
    }
}
