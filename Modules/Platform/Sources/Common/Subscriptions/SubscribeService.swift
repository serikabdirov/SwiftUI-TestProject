//
// SubscribeService.swift
//
// Copyright ©  Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol SubscribeService {
    // TODO: убрать отсюда метод currentSubscription. Доступ к текущей подписке только через SubscriptionManager
    /// Get subscribe info
    func currentSubscription() async throws -> SubscribeModel
    /// Get subscribe benefits
    func getSubscribeBenefits() async throws -> [SubscribeBenefitModel]
    /// Get tariff plans
    func getTariffPlans() async throws -> [SubscribeTariffModel]
}
