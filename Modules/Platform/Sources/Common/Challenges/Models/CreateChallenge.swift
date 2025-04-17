//
//  CreateChallenge.swift
//  Platform
//
//  Created by Александр Болотов on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable
import Foundation

public struct CreateChallenge: Codable {
    public let title: String
    public let rules: String
    public let coverId: Int
    @LossyOptional
    public var courseId: Int?
    @LossyOptional
    public var trainingId: Int?
    public var ageGroup: AgeGroup
    public let schedule: ScheduleList
    public let hashtag: String?
    @DateValue<Platform.YearMonthDayStrategy>
    public var startDate: Date
    @LossyOptionalDateValue<Platform.YearMonthDayStrategy>
    public var endDate: Date?
    public let countriesIds: [Int]

    public init(
        title: String,
        rules: String,
        coverId: Int,
        courseId: Int? = nil,
        trainingId: Int? = nil,
        ageGroup: AgeGroup,
        schedule: ScheduleList,
        hashtag: String?,
        startDate: Date,
        endDate: Date? = nil,
        countriesIds: [Int]
    ) {
        self.title = title
        self.rules = rules
        self.coverId = coverId
        self.courseId = courseId
        self.trainingId = trainingId
        self.ageGroup = ageGroup
        self.schedule = schedule
        self.hashtag = hashtag
        self.startDate = startDate
        self.endDate = endDate
        self.countriesIds = countriesIds
    }
}

public struct AgeGroup: Codable {
    public let lower: Int
    public let upper: Int

    public init(lower: Int, upper: Int) {
        self.lower = lower
        self.upper = upper
    }
}
