//
//  SubscriptionManagerImpl.swift
//  Platform
//
//  Created by Zart Arn on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import StoreKit

public final class SubscriptionManagerImpl: SubscriptionManager {
    
    private let service: SubscriptionManagerService
    private let iapManager: IAPManager
    private var current: SubscribeModel?
    private var hasLoaded: Bool = false
    
    public var hasActiveSubscription: Bool {
        return true;
        guard let current, let expirationDate = current.expirationDate else {
            return false
        }
        return (current.status == .active) && (expirationDate < Date())
    }
    
    init(service: SubscriptionManagerService, iapManager: IAPManager) {
        self.service = service
        self.iapManager = iapManager
    }
    
    public func getCurrentOrLoad() async throws -> SubscribeModel? {
        if hasLoaded {
            return current
        }
        return try await currentSubscription()
    }
    
    public func getProducts(productIds: Set<String>) async throws -> [Product] {
        try await iapManager.fetchSubscriptions(productIDs: productIds)
    }
    
    public func purchase(productId: String, in scene: UIScene) async throws {
        // TODO: - make it well
        guard let product = iapManager.products.first(where: { $0.id == productId }) else {
            throw IAPError.productNotFound
        }
        await iapManager.purchaseProduct(product, in: scene)
    }
    
    // MARK: - Private methods
    
    private func currentSubscription() async throws -> SubscribeModel? {
        do {
            current = try await service.currentSubscription()
            return current
        } catch {
            current = nil
            guard let composableError = error as? ComposableError,
               let apiError = composableError.traverseUnderlying(searching: ApiErrorModel.self),
               apiError.httpStatusCode == 404 else {
                throw error
            }
            return nil
        }
    }
    

}

enum IAPError: Error {
    case productNotFound
}


final class IAPManager {
    
    var products = [Product]()

    @MainActor
    func fetchSubscriptions(productIDs: Set<String>) async throws -> [Product] {
        let subscriptionIDs: Set<String> = ["2025_month_plan", "primary_year_subscription"]
        let _products = try await Product.products(for: subscriptionIDs)
        products = _products
        return products
    }
    
    @MainActor
    func purchaseProduct(_ product: Product, in scene: UIScene) async {
        do {
            let result = try await product.purchase(confirmIn: scene)

            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    print("✅ Покупка успешна: \(transaction.id)")
                    print(transaction)
                    
                    // Отправляем транзакцию на сервер
//                    try await sendTransaction(transaction)

                    // Завершаем транзакцию
                    await transaction.finish()
                } else {
                    print("❌ Ошибка верификации")
                }
            case .pending:
                print("⏳ Покупка ожидает завершения")
            case .userCancelled:
                print("❌ Пользователь отменил покупку")
            @unknown default:
                fatalError()
            }
        } catch {
            print("⚠️ Ошибка покупки: \(error.localizedDescription)")
        }
    }
    
    ///  отправить транзакцию о покупке на сервер
    func sendTransaction(_ transaction: Transaction) async throws {
        
    }

    
    func printSubscriptionsInfo(_ products: [Product]) {
        for product in products {
            if let subscription = product.subscription {
                print("Подписка: \(product.displayName)")
                print("Цена: \(product.price.formatted())")
                print("Длительность: \(subscription.subscriptionPeriod.unit)")
                print("Пробный период: \(subscription.introductoryOffer?.period.unit)")
            }
        }
    }
    
    
    func ttt() {
        
        // Ты можешь добавить кнопку "Управлять подпиской", которая откроет настройки подписок прямо из приложения.
        if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
            UIApplication.shared.open(url)
        }
        
        // Если хочешь направить сразу к подписке твоего приложения, используй:
        if let url = URL(string: "itms-apps://apps.apple.com/account/subscriptions") {
            UIApplication.shared.open(url)
        }
    }
    
    // Добавь SKPaymentQueue.default().add(self) в didFinishLaunchingWithOptions, чтобы отслеживать покупки.
}
