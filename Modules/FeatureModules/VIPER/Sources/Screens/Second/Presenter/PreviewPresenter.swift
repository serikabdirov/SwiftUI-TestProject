//
//  PreviewPresenter.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

final class SecondPreviewPresenter: SecondPresenterProtocol {
    @Injected(\SecondContainer.router)
    private var router: SecondRouterProtocol

    @Injected(\SecondContainer.interactor)
    private var interactor: SecondInteractorProtocol

    @WeakLazyInjected(\SecondContainer.viewState)
    private var viewState: SecondViewState?

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
