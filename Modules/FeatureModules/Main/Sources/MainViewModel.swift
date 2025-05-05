//
//  MainViewModel.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Combine
import DesignSystem

class MainViewModel: ObservableObject {
    @Published
    var data: String?

    @Published
    var isLoading = false

    @Published
    var errorMessage: String?

    @MainActor
    public func load() async {
        isLoading = true
        do {
            try? await Task.sleep(for: .seconds(2))
            throw CancellationError()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func reload() {
        Task { await load() }
    }
}
