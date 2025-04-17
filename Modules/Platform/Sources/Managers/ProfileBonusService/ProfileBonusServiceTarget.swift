//
//  WorkSheetManagerServiceTarget.swift
//  Platform
//
//  Created by Vladislav on 11.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

#if MOCK
    typealias ProfileBonusServiceTarget = ProfileBonusServiceTargetMock
#else
    typealias ProfileBonusServiceTarget = ProfileBonusServiceTargetApi
#endif

protocol ProfileBonusServiceTargetProtocol {
    static func getProfileBonusBalance() -> BallTarget
}

public enum ProfileBonusServiceTargetApi: ProfileBonusServiceTargetProtocol {
    public static func getProfileBonusBalance() -> BallTarget {
        BallTargetModel(
            path: "/api/bonus/account/",
            method: .get
        )
    }
}

public enum ProfileBonusServiceTargetMock: ProfileBonusServiceTargetProtocol {
    static func getProfileBonusBalance() -> BallTarget {
        BallTargetModel(path: "")
    }
}
