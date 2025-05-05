//
//  AsyncContentView.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public enum LoadingState {
    case idle
    case loading
    case loaded
    case failed(Error)
}

public struct AsyncContentView<Source: LoadableObject>: ViewModifier {
    @ObservedObject
    var source: Source

    init(source: Source) {
        self.source = source
    }

    public func body(content: Content) -> some View {
        ZStack {
            content

            switch source.loadingState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
            case let .failed(error):
                VStack {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 10)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3))
            case .idle, .loaded:
                EmptyView() // ничего поверх content
            }
        }
    }
}

public extension View {
    func asyncContent(_ source: some LoadableObject) -> some View {
        modifier(AsyncContentView(source: source))
    }
}
