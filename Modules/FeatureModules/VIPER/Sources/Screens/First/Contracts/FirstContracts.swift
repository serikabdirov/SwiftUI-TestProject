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
protocol FirstRouterProtocol: RouterProtocol {}

// Presenter
protocol FirstPresenterProtocol: PresenterProtocol {
    func updateData()

    func showSecond()
    func showMain()

    func presentSecond()
}

// Interactor
protocol FirstInteractorProtocol: InteractorProtocol {
    func getData() async throws -> String
}
