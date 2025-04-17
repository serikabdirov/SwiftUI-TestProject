//
//  Challenges.swift
//  Challenge
//
//  Created by Nikita Ziganshin on 31.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import R

public struct ChallengesDataModel {
    public let challengesData: [ChallengGroup]
    public init(challengesData: [ChallengGroup]) {
        self.challengesData = challengesData
    }
}

public struct ChallengGroup: Hashable {
    public let challenges: [ChallengeBase]
    public let type: ChallengesViewType

    public init(challenges: [ChallengeBase], type: ChallengesViewType) {
        self.challenges = challenges
        self.type = type
    }
}

public extension ChallengGroup {
    static var mockData: ChallengGroup {
        let availableChallenges: [ChallengeBase] = [.init(
            id: 1,
            recordId: nil,
            title: "Заголовок",
            icon: URL(
                string: "https://storage.yandexcloud.net/ball-in-media/cover/challenge.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ad2910795439850c9b3e220ae6b781b3a60e8d08c2f9dcaa0232ecfeb96e285d"
            )!,
            level: .beginner,
            isAuthor: true,
            startDate: Date().startOfMonth(),
            endDate: Date().endOfMonth(),
            status: .completed,
            entityStatus: .created,
            awardRatingPoints: 20,
            numberOfPractices: 14,
            completedPractices: 7,
            multiplier: 1.5,
            created: .now
        )]

        return ChallengGroup(challenges: availableChallenges, type: .available)
    }
}

public enum ChallengesViewType: Hashable, CaseIterable {
    case available
    case my
    case created

    public var title: String {
        switch self {
        case .available:
            RStrings.Ls.Challenges.List.Category.available
        case .my:
            RStrings.Ls.Challenges.List.Category.my
        case .created:
            RStrings.Ls.Challenges.List.Category.created
        }
    }
}
