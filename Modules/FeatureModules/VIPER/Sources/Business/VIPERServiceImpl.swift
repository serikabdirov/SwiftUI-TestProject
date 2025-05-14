//
//  VIPERServiceImpl.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Platform

final class VIPERServiceImpl {
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

extension VIPERServiceImpl: VIPERService {
    func getData() async throws -> String {
        try await Task.sleep(for: .seconds(2))

        return "Hello, World!"
    }
}
