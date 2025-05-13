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
        let newData = interactor.getData()
        viewState?.dataString = "PREVIEW :: \(newData)"
    }
}
