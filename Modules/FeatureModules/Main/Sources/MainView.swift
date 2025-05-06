//
//  MainView.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DesignSystem
import SwiftUI
import Factory

extension MainContainer {
    var mainViewModel: Factory<MainViewModel> {
        self { MainViewModel() }
    }
}

public struct MainView: View {
    @InjectedObservable(\MainContainer.mainViewModel) var viewModel

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
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
