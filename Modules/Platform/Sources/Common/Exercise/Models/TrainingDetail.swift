//
//  TrainingDetail.swift
//  Exercise
//
//  Created by Серик Абдиров on 06.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable
import Foundation

public struct TrainingDetail: Codable, Identifiable {
    public let id: Int
    public let recordId: Int?
    public let title: String
    public let level: Level?
    public let icon: URL?
    public let uid: Int?
    public let status: Status?
    public let awardPoints: Int
    public let awardedPoints: Int?
    public let numberOfExercises: Int
    public let completedExercises: Int
    public let description: String?

    public let inventory: [String]

    public let positions: [PositionType]

    public let exercises: [Exercise]

    public let trainingScheduleId: Int?

    public var nextPlannedDate: Date? {
        if let trainingScheduleId {
            nextTrainingDate
        } else {
            plannedDate
        }
    }

    @OptionalDateValue<ISO8601Strategy>
    private var nextTrainingDate: Date?
    @OptionalDateValue<ISO8601Strategy>
    private var plannedDate: Date?
}
