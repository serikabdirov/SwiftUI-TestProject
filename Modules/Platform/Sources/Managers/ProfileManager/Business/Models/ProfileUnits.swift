//
//  ProfileUnits.swift
//  Platform
//
//  Created by Zart Arn on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import R

public protocol MeasurementUnits {
    var settingsTitle: String { get }
}

public enum DistanceUnits: String, Codable, CaseIterable, MeasurementUnits {
    case km
    case mi

    public var unit: UnitLength {
        switch self {
        case .km:
            .kilometers
        case .mi:
            .miles
        }
    }
    
    public var settingsTitle: String {
        switch self {
        case .km:
            RStrings.Ls.Profile.Settings.Distance.Unit.km
        case .mi:
            RStrings.Ls.Profile.Settings.Distance.Unit.mi
        }
    }
}

public enum WeightUnits: String, Codable, CaseIterable, MeasurementUnits {
    case kg
    case lb

    public var settingsTitle: String {
        switch self {
        case .kg:
            RStrings.Ls.Profile.Settings.Weight.Unit.kg
        case .lb:
            RStrings.Ls.Profile.Settings.Weight.Unit.lb
        }
    }
}

public enum HeightUnits: String, Codable, CaseIterable, MeasurementUnits {
    case cm
    case inInch = "in"

    public var settingsTitle: String {
        switch self {
        case .cm:
            RStrings.Ls.Profile.Settings.Height.Unit.sm
        case .inInch:
            RStrings.Ls.Profile.Settings.Height.Unit.in
        }
    }
}
