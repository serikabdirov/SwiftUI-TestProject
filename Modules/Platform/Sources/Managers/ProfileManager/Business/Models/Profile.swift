//
//  Profile.swift
//  Platform
//
//  Created by Евграфов Максим on 12.11.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import BetterCodable
import Foundation
import R

public struct Profile: Codable {
    public let phone: String
    public let photo: URL?
    public let nickname: String?
    public let level: Level?
    public let language: String
    public let timezone: String
    public let socialNetworks: [SocialNetwork]?
    public let questionnaire: QuestionnaireState
    public let preferences: ProfilePreferences
}

// MARK: - Level

public enum Level: String, Codable, CaseIterable {
    case beginner
    case intermediate
    case advanced
}

// MARK: - QuestionnaireStatus

public enum QuestionnaireStatus {
    case notDetermined
    case skipped
    case completed
}

public struct QuestionnaireState: Codable {
    private let skipped: Bool
    private let completed: Bool

    public var status: QuestionnaireStatus {
        switch (skipped, completed) {
        case (false, false):
                .notDetermined
        case (_, true):
                .completed
        case (true, false):
                .skipped
        }
    }
}

// MARK: - Preferences

public struct ProfilePreferences: Codable {
    public let approachesBreak: ApproachesBreakType
    public let exercisesBreak: ExercisesBreakType
    public let heightUnit: HeightUnits
    public let weightUnit: WeightUnits
    public let distanceUnit: DistanceUnits
}

// MARK: - Other

public extension Profile {
    func getSocialNetworkURL(for type: SocialNetworkType) -> String? {
        socialNetworks?.first(where: { $0.type == type })?.url
    }
}
