//
//  GamerСharacteristicsStyle.swift
//  Platform
//
//  Created by Zart Arn on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import R

public extension PositionType {
    var title: String {
        switch self {
        case .goalkeeper:
            RStrings.Ls.Model.Position.goalkeeper
        case .defender:
            RStrings.Ls.Model.Position.defender
        case .midfielder:
            RStrings.Ls.Model.Position.midfielder
        case .forward:
            RStrings.Ls.Model.Position.forward
        }
    }
}

public extension KickLegType {
    var title: String {
        switch self {
        case .left:
            RStrings.Ls.Form.Striking.Leg.left
        case .right:
            RStrings.Ls.Form.Striking.Leg.right
        case .both:
            RStrings.Ls.Form.Striking.Leg.both
        }
    }
}
