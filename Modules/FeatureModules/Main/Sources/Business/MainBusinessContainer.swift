//
//  MainBusinessContainer.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory

extension Container {
    var mainService: Factory<MainService> {
        self { MainServiceImpl(apiClient: self.mainApiClient.resolve() ) }
    }
}
