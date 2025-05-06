//
//  LoadingView.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import ActivityIndicatorView
import SwiftUI

public struct LoadingViewModifier<ActivityView: View>: ViewModifier {
    @Binding
    private var isLoading: Bool

    private let activityView: ActivityView

    init(
        isLoading: Binding<Bool>,
        _ activityView: @escaping () -> ActivityView
    ) {
        self._isLoading = isLoading
        self.activityView = activityView()
    }

    public func body(content: Content) -> some View {
        ZStack {
            content

            if isLoading {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()

                activityView
            }
        }
    }
}

public extension View {
    func loadingState(_ isLoading: Binding<Bool>, _ activityView: @escaping () -> some View) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading, activityView))
    }

    func loadingState(_ isLoading: Binding<Bool>) -> some View {
        loadingState(isLoading) {
            ActivityIndicatorView(isVisible: isLoading, type: .growingArc(.red, lineWidth: 4))
                .frame(width: 50, height: 50)
        }
    }
}
