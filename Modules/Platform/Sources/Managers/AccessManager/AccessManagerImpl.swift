//
//  AccessManagerImpl.swift
//  Platform
//
//  Created by Zart Arn on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public final class AccessManagerImpl: AccessManager {
    
    private let profileManager: ProfileManager // контроль анкеты
    private let subscriptionManager: SubscriptionManager // контроль подписки
    private let router: AccessRouter
    
    init(
        profileManager: ProfileManager,
        subscriptionManager: SubscriptionManager,
        router: AccessRouter
    ) {
        self.profileManager = profileManager
        self.subscriptionManager = subscriptionManager
        self.router = router
    }
        
    public func hasAccess(for access: AccessLevel) -> Bool {
        switch access {
        case .free:
            true
        case .questionnaire:
            surveyAccess()
        case .subscription:
            subscriptionAccess()
        case .full:
            surveyAccess() && subscriptionAccess()
        }
    }
    
    public func showUnderAccess(for content: ContentType, access: AccessLevel, handler: (() -> Void)?) {
        // если доступ есть - переходим к контенту
        if hasAccess(for: access) {
            handler?()
            return
        }

        // определяем какой алерт показывать
        switch access {
        case .free:
            /// уже выполнили успешный сценарий выше
            return
        case .questionnaire:
            router.showAccessAlert(for: content, alert: .survey)
        case .subscription:
            router.showAccessAlert(for: content, alert: .subscription)
        case .full:
            if !surveyAccess() {
                router.showAccessAlert(for: content, alert: .survey)
            } else if !subscriptionAccess() {
                router.showAccessAlert(for: content, alert: .subscription)
            } else {
                /// уже выполнили успешный сценарий выше
            }
        }
    }
}

private extension AccessManagerImpl {
    func surveyAccess() -> Bool {
        profileManager.profile?.questionnaire.status == .completed
    }
    
    func subscriptionAccess() -> Bool {
        subscriptionManager.hasActiveSubscription
    }
}
