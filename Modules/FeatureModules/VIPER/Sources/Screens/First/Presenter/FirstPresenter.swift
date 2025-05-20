//
//  Presenter.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import Platform
import SwiftUI

final class FirstPresenter: FirstPresenterProtocol {
    @Injected(\VIPERContainer.coordinator)
    private var coordinator

    @Injected(\TabCoordinatorContainer.tabCoordinator)
    private var tabCoordinator

    @Injected(\FirstContainer.interactor)
    private var interactor

    @WeakLazyInjected(\FirstContainer.viewState)
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

    func showSecond() {
        coordinator.push(.second)
    }

    func showMain() {
        tabCoordinator?.routeToMain()
    }

    func presentSecond() {
        coordinator.present(sheet: .second)
    }
}
