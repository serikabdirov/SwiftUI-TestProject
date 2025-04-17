//
//  ChallengeContext.swift
//  Platform
//
//  Created by Александр Болотов on 11.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public struct ChallengeContext {
    public let challengeId: ChallengeId?
    public let challengesViewType: ChallengesViewType

    public init(challengeId: ChallengeId?, challengesViewType: ChallengesViewType) {
        self.challengeId = challengeId
        self.challengesViewType = challengesViewType
    }
}

public struct ChallengeId {
    public let recordId: Int?
    public let challengeId: Int

    public init(challengeId: Int, recordId: Int? = nil) {
        self.recordId = recordId
        self.challengeId = challengeId
    }
}
