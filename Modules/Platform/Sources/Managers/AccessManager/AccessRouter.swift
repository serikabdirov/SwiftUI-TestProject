//
//  AccessRouter.swift
//  Platform
//
//  Created by Zart Arn on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public enum AccessAlertType {
    case survey
    case subscription
}

public protocol AccessRouter {
    func showAccessAlert(for content: ContentType, alert: AccessAlertType)
}
