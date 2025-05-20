//
//  VIPERContainer.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import Platform

final class VIPERContainer: SharedContainer {
    @TaskLocal
    static var shared = VIPERContainer()
    let manager = ContainerManager()
}

// MARK: - Service

extension VIPERContainer {
    var service: Factory<VIPERService> {
        self {
            VIPERServiceImpl(
                apiClient: NetworkingContainer.shared.apiClient(),
                errorTranslator: ErrorTranslators.unspecifiedDomainErrorTranslator()
                    .eraseToAnyErrorTranslator()
            )
        }
        .singleton
    }
}

extension VIPERContainer {
    var coordinator: Factory<Coordinator<VIPERRouter>> {
        self {
            Coordinator<VIPERRouter>()
        }
        .singleton
    }
}
