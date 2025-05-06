//
//  MainApiClient.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Factory

class MainApiClient {
    func load() async throws -> String {
        "MainApiClient Hello, World!"
    }
}

extension Container {
    var mainApiClient: Factory<MainApiClient> {
        self { MainApiClient() }
    }
}
