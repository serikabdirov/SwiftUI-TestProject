//
//  FormatHelpers.swift
//  Platform
//
//  Created by Александр Болотов on 09.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import PhoneNumberKit

public enum FormatHelpers {
    /// из секунд в строку вида '1 час 34 мин 23 сек'
    public static func formattedTimeAbbreviatedFrom(seconds: Int) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter.string(from: TimeInterval(seconds))
    }
    
    /// из секунд в строку вида '00:34:23'
    public static func formattedTimeFrom(seconds: Int) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(seconds))
    }
    
    /// из секунд в строку вида '34:23'
    public static func formattedTimeMinSecFrom(seconds: Int) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .default
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(seconds))        
    }

    /// из килокалорий в строку вида '1 111 ккал'
    public static func formattedEnergiFrom(kilocalories: Int) -> String? {
        let measurement = Measurement(value: Double(kilocalories), unit: UnitEnergy.kilocalories)
        return measurement.formatted(
            .measurement(
                width: .abbreviated,
                usage: .workout
            )
        )
    }

    /// из даты в строку вида '09.02'
    public static func formattedDateMonthDayFrom(date: Date) -> String? {
        date.formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
    
    /// из даты в строку вида '09.02.2007'
    public static func formattedDateYearMonthDayFrom(date: Date) -> String {
        date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year())
    }
    
    /// из даты в строку вида '11:25'
    public static func formattedDateHourMinutFrom(date: Date) -> String {
        date.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits))
    }
    
    /// форматирование номера телефона в соответствии с региональными стандартами
    public static func formatPhoneNumber(_ phoneNumber: String) -> String {
        let formatter = PhoneNumberFormatter()
        return formatter.string(for: phoneNumber) ?? phoneNumber
    }
    
    /// Форматирует баланс бонусов, разделяя тысячи в зависимости от локали (например, 16800 -> "16 800").
    public static func formatBonusBalance(_ balance: Double) -> String {
        balance.formatted(.number.grouping(.automatic))
    }
    
    /// Форматирует стоимость, разделяя тысячи в зависимости от кода (например, 16800 -> "16 800,00 ₽").
    public static func formatPrice(
        _ price: Decimal,
        code: String,
        fractionLength: Int = 2
    ) -> String {
        price.formatted(.currency(code: code).precision(.fractionLength(fractionLength)))
    }
    
    public static func formattedMonthYearFrom(date: Date) -> String {
        date.formatted(
            .dateTime
                .month(.wide)
                .year()
        ).capitalized 
    }

    public enum DateFormatterFull {
        /// Форматирует дату в строку вида '27 февраля 2025 20:03' (день месяц год часы:минуты)
        public static func formattedDateTimeFullFrom(date: Date) -> String {
            date.formatted(.dateTime.day().month(.wide).year().hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits))
        }
        
        /// Форматирует дату в строку вида '27 февраля' (день месяц)
        public static func formattedDayAndMonthFrom(date: Date) -> String {
            date.formatted(.dateTime.day().month(.wide))
        }
        
        /// Форматирует две даты в строку вида '27 дек. - 10 янв.' (день месяц - день месяц, сокращённый месяц)
        public static func formattedDateRange(from startDate: Date, to endDate: Date?) -> String {
            let startFormatted = startDate.formatted(.dateTime.day().month(.abbreviated))
            if let endDate = endDate {
                let endFormatted = endDate.formatted(.dateTime.day().month(.abbreviated))
                return "\(startFormatted) - \(endFormatted)"
            } else {
                return "\(startFormatted) - N/A"
            }
            
        }
        
        /// Форматирует дату в строку вида '27 февраля 2025' (день месяц год)
        public static func formattedDateFullFrom(date: Date) -> String {
            date.formatted(.dateTime.day().month(.wide).year())
        }
    }
}
