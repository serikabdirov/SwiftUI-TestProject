//
//  TabCoordinatorView.swift
//  SwiftUITestProject
//
//  Created by Серик Абдиров on 20.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI
import Core
import Factory

public struct TabCoordinatorView: View {
    @Bindable var coordinator: TabCoordinator<TabRouter>

    public init(coordinator: TabCoordinator<TabRouter>) {
        self.coordinator = coordinator
    }

    public var body: some View {
        let _ = Self._printChanges()
        TabView(selection: $coordinator.tab) {
            ForEach(TabRouter.allCases) { tab in
                coordinator.build(tab)
                    .tabItem {
                        Text(tab.title ?? "")
                    }
            }
        }
        .environment(coordinator)
    }
}
