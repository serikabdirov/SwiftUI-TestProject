//
//  YearMonthDayStrategy.swift
//  Platform
//
//  Created by Серик Абдиров on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable

public struct YearMonthDayStrategy: DateValueCodableStrategy {
    private static let dateFormatter = DateFormatter.posixDayFormatter

    public static func decode(_ value: String) throws -> Date {
        if let date = YearMonthDayStrategy.dateFormatter.date(from: value) {
            return date
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format:\(value)"))
        }
    }

    public static func encode(_ date: Date) -> String {
        return YearMonthDayStrategy.dateFormatter.string(from: date)
    }
}
