//
//  TabCoordinatorContainer.swift
//  Platform
//
//  Created by Серик Абдиров on 20.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

public final class TabCoordinatorContainer: SharedContainer {
    @TaskLocal
    public static var shared = TabCoordinatorContainer()
    public let manager = ContainerManager()
}

public extension TabCoordinatorContainer {
    var tabCoordinator: Factory<TabCoordinatorProtocol?> {
        self { nil }
            .singleton
    }
}
