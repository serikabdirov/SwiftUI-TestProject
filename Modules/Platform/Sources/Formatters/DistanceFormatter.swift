//
//  DistanceFormatter.swift
//  Platform
//
//  Created by Zart Arn on 04.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public class DistanceFormatter {
    var profile: UserSettings

    var unit: UnitLength {
        profile.preferences?.distanceUnit.unit ?? .kilometers
    }
    
    public var formattedUnit: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
        let measurement = Measurement(value: 1, unit: unit)
        return formatter.string(from: measurement).replacingOccurrences(of: "1", with: "")
            .trimmingCharacters(in: .whitespaces)
    }

    public init(profile: UserSettings) {
        self.profile = profile
    }

    /// из метров в строку вида '4,56 км' или '11 км' (в зависимости от числа)
    public func formattedDistanceFrom(meters: Double) -> String? {
        var measurement = Measurement(value: meters, unit: UnitLength.meters)
        measurement.convert(to: unit)
        return measurement.formatted(Self.distanceFormatted)
    }

    /// переводим введенную дистануцию (в милях или километрах) в метры
    public func distanceToMeters(distance: Double) -> Double {
        var measurement = Measurement(value: distance, unit: unit)
        measurement.convert(to: .meters)
        return measurement.value
    }

    public func formattedPace(from pace: Int?) -> String? {
        guard let pace else { return "-/\(formattedUnit)" }
        switch unit {
        case .miles:
            let milePace = (Double(pace) * 1.609_344).rounded()
            return "\(FormatHelpers.formattedTimeMinSecFrom(seconds: Int(milePace)) ?? "-")/\(formattedUnit)"

        default:
            return "\(FormatHelpers.formattedTimeMinSecFrom(seconds: pace) ?? "-")/\(formattedUnit)"
        }
    }
}

public extension DistanceFormatter {
    static var distanceFormatted: Measurement<UnitLength>.FormatStyle = .measurement(
        width: .abbreviated,
        usage: .asProvided,
        numberFormatStyle: .number.precision(.fractionLength(2))
    )
}
