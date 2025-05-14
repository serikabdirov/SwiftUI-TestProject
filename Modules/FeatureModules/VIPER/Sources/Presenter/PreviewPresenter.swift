//
//  PreviewPresenter.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

final class PreviewPresenter: VIPERPresenterProtocol {
    @Injected(\VIPERContainer.router)
    private var router: VIPERRouterProtocol

    @Injected(\VIPERContainer.interactor)
    private var interactor: VIPERInteractorProtocol

    @WeakLazyInjected(\VIPERContainer.viewState)
    private var viewState: ViewState?

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
