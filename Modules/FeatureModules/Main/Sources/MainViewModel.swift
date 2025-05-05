//
//  MainViewModel.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Combine
import DesignSystem

class MainViewModel: ObservableObject, LoadableObject {
    @Published
    private(set) var loadingState: LoadingState = .idle
    @Published
    var data: String?

    @Published
    var isLoading = false

    @MainActor
    public func load() async {
        isLoading = true
        try? await Task.sleep(for: .seconds(2))
        data = "Hello, World!"
        isLoading = false


//        loadingState = .loading
//
//        do {
//            try await Task.sleep(for: .seconds(2))
//            throw CancellationError()
//            data = "Hello, World!"
//            loadingState = .loaded
//        } catch {
//            loadingState = .failed(error)
//        }
    }

    func reload() {
        Task { await load() }
    }
}
