//
//  Interactor.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import Foundation

final class FirstInteractor: FirstInteractorProtocol {
    @Injected(\VIPERContainer.service)
    private var service

    func getData() async throws -> String {
        try await service.getData()
    }
}
