//
//  CredentialsServiceImpl.swift
//  Platform
//
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

public actor AuthManager {
    
    private let valueRelay = ReplaySubject<Token?>.create(bufferSize: 1)
    private var currentToken: Token?
    private var refreshTask: Task<Token, Error>?
    private let keychainStorage: Storage
    private var refreshService: RefreshService
    
    private var hasTokenLoaded = false
    
    init(keychainStorage: Storage, refreshService: RefreshService) {
        self.keychainStorage = keychainStorage
        self.refreshService = refreshService
    }
    
    func validToken() async throws -> Token {
        await ensureTokenLoaded()
        
        if let handle = refreshTask {
            return try await handle.value
        }
        
        guard let token = currentToken else {
            throw AuthError.missingToken
        }
        
        if token.isValid() {
            return token
        }
        
        return try await refreshToken()
    }
    
    func refreshToken() async throws -> Token {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        let task = Task { () throws -> Token in
            defer { refreshTask = nil }
            
            guard let token = currentToken else {
                throw AuthError.missingToken
            }
            
            let refreshToken = token.refreshToken
            let newToken = try await refreshService.refreshToken(refreshToken)
            await keychainStorage.saveToken(newToken)
            
            currentToken = newToken
            valueRelay.onNext(newToken)
            return newToken
        }
        
        self.refreshTask = task
        
        return try await task.value
    }
    
    private func ensureTokenLoaded() async {
        guard !hasTokenLoaded else { return }
        await keychainStorage.clearIfNeeded()
        currentToken = await keychainStorage.retrieveToken()
        valueRelay.onNext(currentToken)
        hasTokenLoaded = true
    }
}
 
extension AuthManager: @preconcurrency AuthorizationChecker {
    
    public func isAuthorized() async -> Bool {
        await ensureTokenLoaded()
        return currentToken != nil
    }

    public var isAuthorizedDriver: Driver<Bool> {
        valueRelay
            .map { $0 != nil }
            .distinctUntilChanged() // нам важно только наличие токена. он может меняться по refresh
            .asDriver(onErrorDriveWith: .never())
    }
}

// MARK: - CredentialsService

extension AuthManager: CredentialsService {
    public func saveToken(_ token: Token) async {
        await keychainStorage.saveToken(token)
        currentToken = token
        valueRelay.onNext(token)
    }
    
    public func removeToken() async {
        await keychainStorage.removeToken()
        currentToken = nil
        valueRelay.onNext(nil)
    }
}

// MARK: - Error

enum AuthError: Swift.Error {
    case missingToken
}
