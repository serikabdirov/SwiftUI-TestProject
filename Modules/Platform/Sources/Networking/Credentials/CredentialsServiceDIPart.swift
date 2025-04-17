//
//  CredentialsServiceDIPart.swift
//  Platform
//
//  Copyright © 2024 Spider Group. All rights reserved.
//

import DITranquillity
import Foundation
import KeychainAccess
import Networking

class CredentialsDIPart: DIPart {
    static func load(container: DIContainer) {
        
        // Keychain
        container.register {
            Keychain(service: Bundle.main.bundleIdentifier!)
                .accessibility(.afterFirstUnlockThisDeviceOnly)
                .synchronizable(false)
        }
        .as(CredentialsStorage.self)
        
        container.register(KeychainService.init(keychainStorage:))
            .as(Storage.self)
        
        // Authorization Manager
        container.register {
            RefreshServiceImpl.init(
                apiClient: by(tag: ApiClientAuth.self, on: $0),
                errorTranslator: ErrorTranslators.unspecifiedDomainErrorTranslator()
                    .eraseToAnyErrorTranslator()
            )
        }
        .as(RefreshService.self)
        
        container.register(AuthManager.init(keychainStorage:refreshService:))
            .as(AuthManager.self)
            .as(AuthorizationChecker.self)
            .as(CredentialsService.self)
            .lifetime(.perRun(.strong))
    }
}
