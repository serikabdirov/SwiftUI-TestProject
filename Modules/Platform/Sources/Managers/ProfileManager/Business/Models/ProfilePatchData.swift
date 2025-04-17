//
//  ProfilePatchData.swift
//  Platform
//
//  Created by Александр Болотов on 27.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//


// MARK: - Patch profile

public struct ProfilePatchData: Codable {
    public let socialNetworks: [SocialNetworkPatchData]?
    public let preferences: ProfilePreferencesPatchData?

    public init(
        socialNetworks: [SocialNetworkPatchData]? = nil,
        preferences: ProfilePreferencesPatchData? = nil
    ) {
        self.socialNetworks = socialNetworks
        self.preferences = preferences
    }
}

public struct SocialNetworkPatchData: Codable {
    public let type: String
    public let url: URL?

    public init(type: String, url: URL?) {
        self.type = type
        self.url = url
    }

    public enum CodingKeys: String, CodingKey {
        case type
        case url
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        if let url {
            try container.encode(url, forKey: .url)
        } else {
            try container.encodeNil(forKey: .url)
        }
    }
}


public struct ProfilePreferencesPatchData: Codable {
    public let approachesBreak: ApproachesBreakType?
    public let exercisesBreak: ExercisesBreakType?
    public let heightUnit: HeightUnits?
    public let weightUnit: WeightUnits?
    public let distanceUnit: DistanceUnits?
    
    public init(
        approachesBreak: ApproachesBreakType? = nil,
        exercisesBreak: ExercisesBreakType? = nil,
        heightUnit: HeightUnits? = nil,
        weightUnit: WeightUnits? = nil,
        distanceUnit: DistanceUnits? = nil
    ) {
        self.approachesBreak = approachesBreak
        self.exercisesBreak = exercisesBreak
        self.heightUnit = heightUnit
        self.weightUnit = weightUnit
        self.distanceUnit = distanceUnit
    }
}
