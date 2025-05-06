//
//  MainServiceImpl.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//
import Platform

final class MainServiceImpl {
    private let apiClient: MainApiClient

    init(
        apiClient: MainApiClient
    ) {
        self.apiClient = apiClient
    }
}

extension MainServiceImpl: MainService {
    public func load() async throws -> String{
        try await Task.sleep(for: .seconds(2))
        return try await apiClient.load()
    }
}
