//
//  SecondContainer.swift
//  VIPER
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Factory

final class SecondContainer: SharedContainer {
    @TaskLocal
    static var shared = SecondContainer()
    let manager = ContainerManager()
}

// MARK: - Interactor

extension SecondContainer {
    var interactor: Factory<SecondInteractorProtocol> {
        self {
            SecondInteractor()
        }
    }
}

// MARK: - Presenter

extension SecondContainer {
    var presenter: Factory<SecondPresenterProtocol?> {
        self {
            SecondPresenter()
        }
    }
}

// MARK: - ViewState

extension SecondContainer {
    var viewState: Factory<SecondViewState> {
        self {
            SecondViewState()
        }
        .shared
    }
}

extension SecondContainer {
    func setupPreview() {
        presenter.register {
            SecondPreviewPresenter()
        }
    }
}
