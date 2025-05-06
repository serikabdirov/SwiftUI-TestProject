//
//  Environment.swift
//  Platform
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//


import Foundation

/// Namespace for Environment constants
public enum Environment {}

public extension Environment {
    enum Scheme {
        case dev, stage, prod, mock
    }

    static var scheme: Scheme {
        #if DEV
            return .dev
        #elseif STAGE
            return .stage
        #elseif PROD
            return .prod
        #elseif MOCK
            return .mock
        #else
            fatalError("There should be specific scheme")
        #endif
    }
}