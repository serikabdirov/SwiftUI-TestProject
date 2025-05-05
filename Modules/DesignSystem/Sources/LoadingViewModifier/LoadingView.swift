//
//  LoadingView.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import ActivityIndicatorView
import SwiftUI

public struct LoadingViewModifier: ViewModifier {
    @Binding
    private var isLoading: Bool

    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    public func body(content: Content) -> some View {
        ZStack {
            content

            if isLoading {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()

                ActivityIndicatorView(isVisible: $isLoading, type: .growingArc(.red, lineWidth: 4))
                    .frame(width: 50, height: 50)
            }
        }
    }
}

public extension View {
    func loadingState(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
