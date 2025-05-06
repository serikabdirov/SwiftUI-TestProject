//
//  MainContainer.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

final class MainContainer: SharedContainer {
    @TaskLocal static var shared = MainContainer()
    let manager = ContainerManager()
}

extension MainContainer {
    var mainService: Factory<MainService> {
        self { MainServiceImpl(apiClient: Container.shared.mainApiClient() ) }
            .onPreview { MockServiceImpl() }
    }
}
