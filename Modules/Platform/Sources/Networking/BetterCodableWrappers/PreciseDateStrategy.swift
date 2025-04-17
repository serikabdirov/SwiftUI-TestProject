//
//  ISOStrategy.swift
//  Platform
//
//  Created by Vladislav on 10.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//
import Foundation

public struct PreciseDateStrategy: DateValueCodableStrategy {
    public static func decode(_ value: String) throws -> Date {
        guard let date = DateFormatter.preciseDateFormatter.date(from: value) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format: \(value)"))
        }
        return date
    }

    public static func encode(_ date: Date) -> String {
        DateFormatter.preciseDateFormatter.string(from: date)
    }
}
