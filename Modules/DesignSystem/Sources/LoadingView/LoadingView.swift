//
//  LoadingView.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct LoadingView: ViewModifier {
    @Binding private var isLoading: Bool

    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
            } else {
                EmptyView()
            }
        }
    }
}

public extension View {
    func loadingState(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingView(isLoading: isLoading))
    }
}
