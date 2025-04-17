//
//  KeychainService.swift
//  Platform
//
//  Created by Zart Arn on 30.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Core
import Foundation

actor KeychainService: Storage {
    
    let keychainStorage: CredentialsStorage
    
    private let tokenKey = CredentialsKeys.credentialsStorageKey

    @UserDefault(CredentialsKeys.isFirstLogin)
    private var isFirstLogin = true
    
    init(keychainStorage: CredentialsStorage) {
        self.keychainStorage = keychainStorage
    }
    
    func retrieveToken() async -> Token? {
        guard let data = readKeychainData(forKey: tokenKey),
              let token = try? JSONDecoder().decode(Token.self, from: data) else {
            return nil
        }
        return token
    }

    func saveToken(_ token: Token) async {
        if let data = try? JSONEncoder().encode(token) {
            saveKeychainData(data, forKey: tokenKey)
        }
    }
    
    func removeToken() async {
        removeKeychainData(forKey: tokenKey)
    }
    
    func clearIfNeeded() async {
        defer { isFirstLogin = false }
        if isFirstLogin {
            try? keychainStorage.remove(key: tokenKey)
        }
    }
    
    // Приватные методы для работы с Keychain
    private func readKeychainData(forKey key: String) -> Data? {
        try? keychainStorage.getData(key: key)
    }

    private func saveKeychainData(_ data: Data, forKey key: String) {
        try? keychainStorage.set(data: data, key: key)
    }
    
    private func removeKeychainData(forKey key: String) {
        try? keychainStorage.remove(key: key)
    }
}

private enum CredentialsKeys {
    static let credentialsStorageKey = "ru.spider.ball-in.credentials"
    static let isFirstLogin = "ru.spider.ball-in.first-login"
}
