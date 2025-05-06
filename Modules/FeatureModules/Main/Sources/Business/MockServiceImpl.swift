//
//  MockServiceImpl.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

final class MockServiceImpl {}

extension MockServiceImpl: MainService {
    public func load() async throws {
        print("MOCK")
        try await Task.sleep(for: .seconds(2))
    }
}
