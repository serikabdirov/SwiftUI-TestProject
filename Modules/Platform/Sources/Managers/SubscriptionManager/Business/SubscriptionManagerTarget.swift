//
//  SubscriptionManagerTarget.swift
//  Platform
//
//  Created by Zart Arn on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import R

#if MOCK
typealias SubscriptionManagerTarget = SubscriptionManagerTargetMock
#else
typealias SubscriptionManagerTarget = SubscriptionManagerTargetApi
#endif

protocol SubscribeTargetProtocol {
    static func currentSubscription() -> BallTargetModel
    static func sendTransaction(_ transactionId: String) -> BallTargetModel
}

// MARK: - Api Target

enum SubscriptionManagerTargetApi: SubscribeTargetProtocol {
    static func currentSubscription() -> BallTargetModel {
        BallTargetModel(
            path: "/api/subscription/current/",
            method: .get
        )
    }
    
    static func sendTransaction(_ transactionId: String) -> BallTargetModel {
        BallTargetModel(
            path: "/api/subscription/verify/",
            method: .post,
            parameters: .requestParameters(
                parameters: [
                    "transaction_id": transactionId
                ]
            )
        )
    }
}

// MARK: - Mock Target

enum SubscriptionManagerTargetMock: SubscribeTargetProtocol {
    static func currentSubscription() -> BallTargetModel {
        BallTargetModel(
            path: R.Files.Modules.R.Resources.Mock.subscribeJson.path
        )
    }
    
    static func sendTransaction(_ transactionId: String) -> BallTargetModel {
        BallTargetModel(
            path: ""
        )
    }
}
