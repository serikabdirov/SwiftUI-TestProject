//
//  MainView.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DesignSystem
import Factory
import Platform
import SwiftUI

public struct MainView: View {
    @InjectedObservable(\MainContainer.mainViewModel)
    var viewModel
    
    @Injected(\TabCoordinatorContainer.tabCoordinator)
    var tabCoordinator

    public init() {}

    public var body: some View {
        let _ = Self._printChanges()

        bodyView
            .loadingState($viewModel.isLoading)
            .errorAlert($viewModel.errorMessage)
    }

    private var bodyView: some View {
        VStack {
            Text(viewModel.data ?? "")

            Button("Reload") {
                viewModel.reload()
            }

            Button("VIPER") {
                tabCoordinator?.routeToVIPER()
            }
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}
