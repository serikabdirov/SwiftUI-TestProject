//
//  TabRouter.swift
//  SwiftUITestProject
//
//  Created by Серик Абдиров on 20.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Core
import Main
import SwiftUI
import VIPER

public enum TabRouter: NavigationRouter, CaseIterable {
    case main
    case viper

    public var title: String? {
        switch self {
        case .main:
            "Main"
        case .viper:
            "VIPER"
        }
    }

    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .main:
            MainView()
        case .viper:
            VIPERAssembly().build()
        }
    }
}
