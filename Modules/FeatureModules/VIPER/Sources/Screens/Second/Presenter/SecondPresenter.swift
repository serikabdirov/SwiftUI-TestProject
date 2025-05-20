//
//  SecondPresenter.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import SwiftUI

final class SecondPresenter: SecondPresenterProtocol {
    @Injected(\VIPERContainer.coordinator)
    private var coordinator

    @Injected(\SecondContainer.interactor)
    private var interactor

    @WeakLazyInjected(\SecondContainer.viewState)
    private var viewState

    init() {
        print("init SecondPresenter")
    }

    deinit {
        print("deinit SecondPresenter")
    }

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
