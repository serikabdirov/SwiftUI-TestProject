//
//  Schedule.swift
//  Courses
//
//  Created by Серик Абдиров on 10.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable
import Foundation
import R

public typealias ScheduleList = [Schedule]

public struct Schedule: Codable {
    public let weekday: ScheduleWeekday
    @DateValue<HoursMinutesStrategy>
    public var time: Date

    public init(weekday: ScheduleWeekday, time: Date) {
        self.weekday = weekday
        self.time = time
    }

    public enum ScheduleWeekday: String, CaseIterable, Codable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday

        public var title: String {
            switch self {
            case .monday:
                RStrings.Ls.Model.Weekday.monday
            case .tuesday:
                RStrings.Ls.Model.Weekday.tuesday
            case .wednesday:
                RStrings.Ls.Model.Weekday.wednesday
            case .thursday:
                RStrings.Ls.Model.Weekday.thursday
            case .friday:
                RStrings.Ls.Model.Weekday.friday
            case .saturday:
                RStrings.Ls.Model.Weekday.saturday
            case .sunday:
                RStrings.Ls.Model.Weekday.sunday
            }
        }
    }
}

public struct HoursMinutesStrategy: DateValueCodableStrategy {
    public static func decode(_ value: String) throws -> Date {
        if let date = DateFormatter.hoursMinutesFormatter.date(from: value) {
            return date
        } else if let date = DateFormatter.hoursMinutesSecondsFormatter.date(from: value) {
            return date
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format \(value)"))
        }
    }

    public static func encode(_ date: Date) -> String {
        DateFormatter.hoursMinutesFormatter.string(from: date)
    }
}
