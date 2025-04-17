//
//  LevelStyles.swift
//  Platform
//
//  Created by Zart Arn on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import R

public extension Level {
    var title: String {
        switch self {
        case .beginner:
            RStrings.Ls.Model.Level.beginner
        case .intermediate:
            RStrings.Ls.Model.Level.intermediate
        case .advanced:
            RStrings.Ls.Model.Level.advanced
        }
    }
    
    var titleFull: String {
        switch self {
        case .beginner:
            RStrings.Ls.Model.Level.Beginner.full
        case .intermediate:
            RStrings.Ls.Model.Level.Intermediate.full
        case .advanced:
            RStrings.Ls.Model.Level.Advanced.full
        }
    }
}

