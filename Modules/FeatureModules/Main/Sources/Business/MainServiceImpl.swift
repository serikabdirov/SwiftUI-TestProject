//
//  MainServiceImpl.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Platform

final class MainServiceImpl {
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

extension MainServiceImpl: MainService {
    public func load() async throws -> String {
        try await apiClient.load(
            MainTarget.getData(),
            responseSerializer: .ballResponseSerializer(valueType: MainGetData.self)
        )
        .result
        .translateError(using: errorTranslator)
        .get()
        .status
    }
}
