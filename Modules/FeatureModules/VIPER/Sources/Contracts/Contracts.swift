//
//  Contracts.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Core
import SwiftUI

// Router
protocol VIPERRouterProtocol: RouterProtocol {}

// Presenter
protocol VIPERPresenterProtocol: PresenterProtocol {
    func updateData()
}

// Interactor
protocol VIPERInteractorProtocol: InteractorProtocol {
    func getData() async throws -> String
}
