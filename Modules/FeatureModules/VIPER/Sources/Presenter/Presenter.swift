//
//  Presenter.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import SwiftUI

final class Presenter: VIPERPresenterProtocol {
    @Injected(\VIPERContainer.router)
    private var router

    @Injected(\VIPERContainer.interactor)
    private var interactor

    @WeakLazyInjected(\VIPERContainer.viewState)
    private var viewState

    func updateData() {
        Task {
            viewState?.isLoading = true
            defer { viewState?.isLoading = false }
            do {
                let newData = try await interactor.getData()
                viewState?.dataString = newData
            } catch {
                viewState?.errorMessage = error.localizedDescription
            }
        }
    }
}
