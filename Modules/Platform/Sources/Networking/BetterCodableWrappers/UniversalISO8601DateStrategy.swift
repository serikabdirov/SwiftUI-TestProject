//
//  UniversalISO8601DateStrategy.swift
//  Platform
//
//  Created by Александр Болотов on 27.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

public struct UniversalISO8601DateStrategy: DateValueCodableStrategy {
    public static func decode(_ value: String) throws -> Date {
        if let date = DateFormatter.preciseDateFormatter.date(from: value) {
            return date
        } else if let date = DateFormatter.iso8601Formatter.date(from: value) {
            return date
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format: \(value)"))
        }
    }

    public static func encode(_ date: Date) -> String {
        DateFormatter.iso8601Formatter.string(from: date)
    }
}
