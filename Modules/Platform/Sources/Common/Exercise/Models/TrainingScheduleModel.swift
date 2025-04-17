//
//  TrainingScheduleModel.swift
//  Platform
//
//  Created by Серик Абдиров on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable

public struct TrainingScheduleModel: Codable {
    public let id: Int
    public let schedule: ScheduleList
    @OptionalDateValue<YearMonthDayStrategy>
    public var until: Date?
}
