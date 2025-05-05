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
    @Published private(set) var loadingState: LoadingState = .idle
    @Published var data: String?

    @MainActor
    public func load() async {
        loadingState = .loading

        try? await Task.sleep(for: .seconds(2))
        data = "Hello, World!"
        loadingState = .loaded
    }
}
