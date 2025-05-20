//
//  TabCoordinator.swift
//  SwiftUITestProject
//
//  Created by Серик Абдиров on 20.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Core
import SwiftUI
import Platform

@Observable
public final class TabCoordinator<Route: NavigationRouter> {
    var tab: Route

    init(tab: Route) {
        self.tab = tab
    }

    func change(_ route: Route) {
        self.tab = route
    }

    @ViewBuilder
    func build(_ route: Route) -> some View {
        route.view()
            .tag(route)
    }
}

extension TabCoordinator: TabCoordinatorProtocol where Route == TabRouter {
    public func routeToMain() {
        change(.main)
    }

    public func routeToVIPER() {
        change(.viper)
    }
}
