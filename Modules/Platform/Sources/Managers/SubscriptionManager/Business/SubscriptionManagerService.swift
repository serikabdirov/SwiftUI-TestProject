//
//  SubscriptionManagerService.swift
//  Platform
//
//  Created by Zart Arn on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

/// Attension: This Protocol not Public, only Internal
protocol SubscriptionManagerService {
    /// Get current user subscription info
    func currentSubscription() async throws -> SubscribeModel
    /// Send Transaction to server
    func sendTransaction(transactionId: String) async throws
}

// MARK: - SubscriptionManagerServiceImpl

final class SubscriptionManagerServiceImpl {
    private let apiClient: ApiClient
    private let errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>

    init(
        apiClient: ApiClient,
        errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>
    ) {
        self.apiClient = apiClient
        self.errorTranslator = errorTranslator
    }

}

extension SubscriptionManagerServiceImpl: SubscriptionManagerService {
    func currentSubscription() async throws -> SubscribeModel {
        try await apiClient.load(
            SubscriptionManagerTarget.currentSubscription(),
            responseSerializer: .ballResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
    
    func sendTransaction(transactionId: String) async throws {
        try await apiClient.load(
            SubscriptionManagerTarget.sendTransaction(transactionId),
            responseSerializer: .ballEmptyResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
}
