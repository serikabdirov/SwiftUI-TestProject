//
//  CoordinatorView.swift
//  VIPER
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import SwiftUI

struct VIPERCoordinatorView: View {
    @InjectedObservable(\VIPERContainer.coordinator)
    private var coordinator

    var body: some View {
        let _ = Self._printChanges()
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.first)
                .navigationDestination(for: VIPERRouter.self) { route in
                    coordinator.build(route)
                }
                .sheet(item: $coordinator.sheet) { route in
                    coordinator.build(route)
                }
        }
        .environment(coordinator)
    }
}
