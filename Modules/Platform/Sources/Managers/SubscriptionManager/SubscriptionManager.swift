//
//  SubscriptionManager.swift
//  Platform
//
//  Created by Zart Arn on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

public protocol SubscriptionManager {
    /// возвращает true, если текущая подписка загружена и имеет статус active
    var hasActiveSubscription: Bool { get }
    /// получить или загрузить текущую подписку
    func getCurrentOrLoad() async throws -> SubscribeModel?
    /// получить продукты StoreKit
    func getProducts(productIds: Set<String>) async throws -> [Product]
    /// купить продукт StoreKit
    func purchase(productId: String, in scene: UIScene) async throws
}
