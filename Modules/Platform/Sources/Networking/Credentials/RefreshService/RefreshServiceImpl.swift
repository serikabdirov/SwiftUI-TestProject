//
//  RefreshServiceImpl.swift
//  Platform
//
//  Created by Zart Arn on 30.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Networking

class RefreshServiceImpl: RefreshService {
    
    private let apiClient: ApiClient
    private let errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>

    init(
        apiClient: ApiClient,
        errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>
    ) {
        self.apiClient = apiClient
        self.errorTranslator = errorTranslator
    }
    
    func refreshToken(_ token: String) async throws -> Token {
        try await apiClient.load(
            RefreshTarget.refreshToken(token),
            responseSerializer: .ballResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
}
