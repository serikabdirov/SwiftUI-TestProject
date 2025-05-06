//
//  MainService.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public protocol MainService {
    func load() async throws -> String
}
