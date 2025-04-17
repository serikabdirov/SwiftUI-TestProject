//
//  Date+Extensions.swift
//
//  Created by Денис Кожухарь on 30.09.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public extension TimeZone {
    // swiftlint:disable:next force_unwrapping
    static let utc = TimeZone(abbreviation: "UTC")!
}

public extension Calendar {
    static var utc: Calendar {
        Calendar.withTimeZone(.utc)
    }

    static func withTimeZone(_ timeZone: TimeZone) -> Calendar {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        return calendar
    }
}

public extension Date {
    func replaceTimeZone(_ timeZone: TimeZone, using calendar: Calendar = .current) -> Date? {
        var components = calendar.dateComponents(
            [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: self
        )
        components.timeZone = timeZone
        return calendar.date(from: components)
    }
    
        func startOfMonth() -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: self)
    
            return calendar.date(from: components) ?? Date()
        }

        func endOfMonth() -> Date {
            let calendar = Calendar.current
            var components = DateComponents()
            components.month = 1
            components.second = -1
            
            return calendar.date(byAdding: components, to: self.startOfMonth())!
        }
    
    func nextMonth() -> Date? {
        var components = DateComponents()
        components.month = 1
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    func prevMonth() -> Date? {
        var components = DateComponents()
        components.month = -1
        return Calendar.current.date(byAdding: components, to: self)
    }
}
