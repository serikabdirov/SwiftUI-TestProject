//
//  MainView.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct MainView: View {
    @ObservedObject
    var viewModel: MainViewModel

    public var body: some View {
        let _ = Self._printChanges()

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
        .loadingState($viewModel.isLoading)
//        .asyncContent(viewModel)
    }
}
