//
//  AccessManager.swift
//  Platform
//
//  Created by Zart Arn on 10.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public enum AccessLevel {
    /// разрешено без условий
    case free
    ///  для доступа необходимо заполнить анкету
    case questionnaire
    ///  для доступа необходимо приобрести подписку
    case subscription
    /// для доступа необходима анкета и подписка
    case full
}

public enum ContentType {
    case training
    case course
    case challenge
    case event

}

/// Менеджер управления доступом к контенту
public protocol AccessManager {
    func hasAccess(for access: AccessLevel) -> Bool
    func showUnderAccess(for content: ContentType, access: AccessLevel, handler: (() -> Void)?)
}
