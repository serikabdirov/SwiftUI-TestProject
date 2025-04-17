//
//  CredentialsStorage.swift
//  Platform
//
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation
import KeychainAccess

protocol Storage {
    func retrieveToken() async -> Token?
    func saveToken(_ token: Token) async
    func removeToken() async
    func clearIfNeeded() async
}

public protocol CredentialsStorage {
    func getString(key: String) throws -> String?
    func getData(key: String) throws -> Data?
    func set(string: String, key: String) throws
    func set(data: Data, key: String) throws
    func remove(key: String) throws
}

extension Keychain: CredentialsStorage {
    public func getString(key: String) throws -> String? {
        try getString(key)
    }

    public func getData(key: String) throws -> Data? {
        try getData(key)
    }

    public func remove(key: String) throws {
        try remove(key)
    }

    public func set(string: String, key: String) throws {
        try set(string, key: key)
    }

    public func set(data: Data, key: String) throws {
        try set(data, key: key)
    }
}
