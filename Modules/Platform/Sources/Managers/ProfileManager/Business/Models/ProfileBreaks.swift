//
//  ProfileBreaks.swift
//  Platform
//
//  Created by Zart Arn on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

/// in seconds
public enum ApproachesBreakType: Int, Codable, CaseIterable {
    /// 30 sec
    case _30 = 30
    /// 60 sec
    case _60 = 60
    /// 90 sec
    case _90 = 90
    /// 120 sec
    case _120 = 120
    /// 150 sec
    case _150 = 150
    /// case 180 sec
    case _180 = 180
    /// case 210 sec
    case _210 = 210
    
    /// "1 min, 40 sec"
    public var durationText: String {
        Duration.seconds(self.rawValue)
            .formatted(.units(width: .abbreviated))
    }
}

public enum ExercisesBreakType: Int, Codable, CaseIterable {
    /// 30 sec
    case _30 = 30
    /// 60 sec
    case _60 = 60
    /// 90 sec
    case _90 = 90
    /// 120 sec
    case _120 = 120
    /// 150 sec
    case _150 = 150
    /// case 180 sec
    case _180 = 180
    /// case 210 sec
    case _210 = 210
    
    /// "1 min, 40 sec"
    public var durationText: String {
        Duration.seconds(self.rawValue)
            .formatted(.units(width: .abbreviated))
    }
}
