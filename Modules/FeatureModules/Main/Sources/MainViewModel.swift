//
//  MainViewModel.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Combine
import DesignSystem
import Factory
import Observation

@Observable
class MainViewModel {
    var data: String?
    var isLoading = false
    var errorMessage: String?

    @ObservationIgnored
    @Injected(\.mainService) private var service

    @MainActor
    public func load() async {
        isLoading = true
        do {
            try await service.load()
            data = "Hello, World!"
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func reload() {
        Task { await load() }
    }
}
