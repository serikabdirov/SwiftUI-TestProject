//
//  PreviewPresenter.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

final class FirstPreviewPresenter: FirstPresenterProtocol {
    @Injected(\FirstContainer.router)
    private var router: FirstRouterProtocol

    @Injected(\FirstContainer.interactor)
    private var interactor: FirstInteractorProtocol

    @WeakLazyInjected(\FirstContainer.viewState)
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
