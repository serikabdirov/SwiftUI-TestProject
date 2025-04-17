//
//  ChallengeDetail.swift
//  Platform
//
//  Created by Александр Болотов on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

// MARK: - ChallengeDetail

public struct ChallengeDetail: Codable {
    public let id: Int
    public let recordId: Int?
    public let title: String
    public let rules: String
    public let icon: URL
    public let level: Level
    public let isAuthor: Bool
    @DateValue<YearMonthDayStrategy>
    public var startDate: Date
    @OptionalDateValue<YearMonthDayStrategy>
    public var endDate: Date?
    public let status: ChallengeStatus
    public let entityStatus: ChallengeEntityStatus
    public let awardRatingPoints: Int?
    public let numberOfPractices: Int?
    public let completedPractices: Int?
    public let hashtag: String?
    public let multiplier: Double?
    public let ageGroup: AgeGroup
    public let positions: [PositionType]
    public let inventory: [String]
    public let numberOfParticipants: Int?
    public let requiredRating: RequiredRating
    public let practices : PracticesList
    public let sourceCourse: SourceContent?
    public let sourceTraining: SourceContent?
    public let author: ChallengeAuthor?
    public let schedule: ScheduleList
    public let countries: [Country]
    public let reasonForRejecting: String?
    public let coverId: Int?
    @OptionalDateValue<ISO8601Strategy>
    public var nextPracticeDate: Date?

    public init(
        id: Int,
        recordId: Int?,
        title: String,
        rules: String,
        icon: URL,
        level: Level,
        isAuthor: Bool,
        startDate: Date,
        endDate: Date?,
        status: ChallengeStatus,
        entityStatus: ChallengeEntityStatus,
        awardRatingPoints: Int?,
        numberOfPractices: Int,
        completedPractices: Int,
        hashtag: String?,
        multiplier: Double?,
        ageGroup: AgeGroup,
        positions: [PositionType],
        inventory: [String],
        numberOfParticipants: Int?,
        requiredRating: RequiredRating,
        practices : PracticesList,
        sourceCourse: SourceContent?,
        sourceTraining: SourceContent?,
        author: ChallengeAuthor?,
        schedule: ScheduleList,
        countries: [Country],
        reasonForRejecting: String?,
        coverId: Int?,
        nextPracticeDate: Date?
    ) {
        self.id = id
        self.recordId = recordId
        self.title = title
        self.rules = rules
        self.icon = icon
        self.level = level
        self.isAuthor = isAuthor
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.entityStatus = entityStatus
        self.awardRatingPoints = awardRatingPoints
        self.numberOfPractices = numberOfPractices
        self.completedPractices = completedPractices
        self.hashtag = hashtag
        self.multiplier = multiplier
        self.ageGroup = ageGroup
        self.positions = positions
        self.inventory = inventory
        self.numberOfParticipants = numberOfParticipants
        self.requiredRating = requiredRating
        self.practices = practices
        self.sourceCourse = sourceCourse
        self.sourceTraining = sourceTraining
        self.author = author
        self.schedule = schedule
        self.countries = countries
        self.reasonForRejecting = reasonForRejecting
        self.coverId = coverId
        self.nextPracticeDate = nextPracticeDate
    }
}

public struct ChallengeAuthor: Codable {
    public let nickname: String?
    public let photo: URL?
}

public struct RequiredRating: Codable {
    public let lower: Int
    public let upper: Int
}

public struct SourceContent: Codable {
    public let id: Int
    public let title: String
    public let icon: URL?
}
