//
//  Container.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

final class VIPERContainer: SharedContainer {
    @TaskLocal
    static var shared = VIPERContainer()
    let manager = ContainerManager()
}

// MARK: - Router

extension VIPERContainer {
    var router: Factory<VIPERRouterProtocol> {
        self {
            Router()
        }
    }
}

// MARK: - Interactor

extension VIPERContainer {
    var interactor: Factory<VIPERInteractorProtocol> {
        self {
            Interactor()
        }
    }
}

// MARK: - Presenter

extension VIPERContainer {
    var presenter: Factory<VIPERPresenterProtocol?> {
        self {
            Presenter()
        }
    }
}

// MARK: - ViewState

 extension VIPERContainer {
    var viewState: Factory<ViewState> {
        self {
            ViewState()
        }
    }
 }
