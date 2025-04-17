//
//  PostScheduleModel.swift
//  Platform
//
//  Created by Серик Абдиров on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//
import BetterCodable

public struct PostScheduleModel: Codable {
    public let trainingId: Int
    public let schedule: ScheduleList
    @OptionalDateValue<YearMonthDayStrategy>
    public var until: Date?

    public init(trainingId: Int, schedule: ScheduleList, until: Date? = nil) {
        self.trainingId = trainingId
        self.schedule = schedule
        self.until = until
    }
}
