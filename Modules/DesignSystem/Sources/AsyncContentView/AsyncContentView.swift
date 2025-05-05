//
//  AsyncContentView.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct AsyncContentView<Source: LoadableObject>: ViewModifier {
    @ObservedObject
    var source: Source

    init(source: Source) {
        self.source = source
    }

    public func body(content: Content) -> some View {
        switch source.loadingState {
        case .idle:
            ProgressView()
                .onAppear {
                    Task {
                        await source.load()
                    }
                }
        case .loading:
            ProgressView()
        case let .failed(error):
            Text(error.localizedDescription)
        case .loaded:
            content
        }
    }
}

public extension View {
    func asyncContent(_ source: some LoadableObject) -> some View {
        modifier(AsyncContentView(source: source))
    }
}
