//
//  SecondContracts.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Core
import SwiftUI

// Router
protocol SecondRouterProtocol: RouterProtocol {}

// Presenter
protocol SecondPresenterProtocol: PresenterProtocol {
    func updateData()
}

// Interactor
protocol SecondInteractorProtocol: InteractorProtocol {
    func getData() async throws -> String
}
