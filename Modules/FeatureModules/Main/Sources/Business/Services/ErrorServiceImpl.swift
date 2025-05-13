//
//  ErrorServiceImpl.swift
//  Main
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

final class ErrorServiceImpl {}

extension ErrorServiceImpl: MainService {
    public func load() async throws -> String {
        try await Task.sleep(for: .seconds(2))

        throw CancellationError()
    }
}
