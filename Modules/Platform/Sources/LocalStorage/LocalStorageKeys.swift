//
//  LocalStorageKeys.swift
//  Platform
//
//  Created by Zart Arn on 10.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public enum LocalStorageKeys {
    case profile
    case anketa
}

public extension LocalStorageKeys {
    var key: String {
        switch self {
        case .profile:
            "user-profile"
        case .anketa:
            "user-anketa"
        }
    }
}
