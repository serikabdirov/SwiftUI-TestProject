//
//  CourseDetail.swift
//  Courses
//
//  Created by Серик Абдиров on 07.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable

public struct CourseDetail: Identifiable, Codable {
    public let id: Int
    public let recordId: Int?
    public let status: Status
    public let title: String
    public let icon: URL?
    public let free: Bool
    public let levels: [Level]
    public let awardPoints: Int
    public let numberOfPractices: Int
    public let completedPractices: Int
    public let awardedPoints: Int
    public let description: String?
    public let inventory: [String]
    public let positions: [PositionType]
    @OptionalDateValue<ISO8601Strategy>
    public var nextPracticeDate: Date?
    public let practices: PracticesList
    public let reason: String?
    public let verboseReason: String?

    public let entityStatus: EntityStatus

    public init(
        id: Int,
        recordId: Int?,
        status: Status,
        title: String,
        icon: URL?,
        free: Bool,
        levels: [Level],
        awardPoints: Int,
        numberOfPractices: Int,
        completedPractices: Int,
        awardedPoints: Int,
        description: String?,
        inventory: [String],
        positions: [PositionType],
        nextPracticeDate: Date? = nil,
        practices: PracticesList,
        reason: String?,
        verboseReason: String?,
        entityStatus: EntityStatus
    ) {
        self.id = id
        self.recordId = recordId
        self.status = status
        self.title = title
        self.icon = icon
        self.free = free
        self.levels = levels
        self.awardPoints = awardPoints
        self.numberOfPractices = numberOfPractices
        self.completedPractices = completedPractices
        self.awardedPoints = awardedPoints
        self.description = description
        self.inventory = inventory
        self.positions = positions
        self.nextPracticeDate = nextPracticeDate
        self.practices = practices
        self.reason = reason
        self.verboseReason = verboseReason
        self.entityStatus = entityStatus
    }

    public enum EntityStatus: String, Codable {
        case draft
        case active
        case archived
    }
}
