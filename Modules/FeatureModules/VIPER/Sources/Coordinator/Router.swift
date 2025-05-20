//
//  Router.swift
//  VIPER
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Core
import SwiftUI

enum VIPERRouter: NavigationRouter {
    case first
    case second

    var title: String? {
        switch self {
        case .first:
            return "First"
        case .second:
            return "Second"
        }
    }

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .first:
            FirstView()
        case .second:
            SecondView()
        }
    }
}
