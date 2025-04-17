//
//  Untitled.swift
//  Platform
//
//  Created by Zart Arn on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public enum PositionType: String, Codable, CaseIterable {
    case goalkeeper
    case defender
    case midfielder
    case forward
}

public enum KickLegType: String, Codable, CaseIterable {
    case left
    case right
    case both
}
