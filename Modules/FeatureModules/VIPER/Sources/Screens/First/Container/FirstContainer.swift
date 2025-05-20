//
//  FirstContainer.swift
//  VIPER
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Factory

final class FirstContainer: SharedContainer {
    @TaskLocal
    static var shared = FirstContainer()
    let manager = ContainerManager()
}

// MARK: - Interactor

extension FirstContainer {
    var interactor: Factory<FirstInteractorProtocol> {
        self {
            FirstInteractor()
        }
    }
}

// MARK: - Presenter

extension FirstContainer {
    var presenter: Factory<FirstPresenterProtocol?> {
        self {
            FirstPresenter()
        }
    }
}

// MARK: - ViewState

extension FirstContainer {
    var viewState: Factory<FirstViewState> {
        self {
            FirstViewState()
        }
        .shared
    }
}

extension FirstContainer {
    func setupPreview() {
        presenter.register {
            FirstPreviewPresenter()
        }
    }
}
