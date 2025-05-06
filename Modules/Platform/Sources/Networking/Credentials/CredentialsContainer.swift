//
//  CredentialsContainer.swift
//  Platform
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import KeychainAccess
import Networking

public final class CredentialsContainer: SharedContainer {
    @TaskLocal
    public static var shared = CredentialsContainer()
    public let manager = ContainerManager()
}

extension CredentialsContainer {
    var keychain: Factory<CredentialsStorage> {
        self {
            Keychain(service: Bundle.main.bundleIdentifier!)
                .accessibility(.afterFirstUnlockThisDeviceOnly)
                .synchronizable(false)
        }
    }

    var keychainService: Factory<Storage> {
        self {
            KeychainService(keychainStorage: self.keychain())
        }
    }

//    var refreshService: Factory<RefreshService> {
//        self {
//            RefreshServiceImpl(
//                apiClient: by(tag: ApiClientAuth.self, on: $0),
//                errorTranslator: ErrorTranslators.unspecifiedDomainErrorTranslator()
//                    .eraseToAnyErrorTranslator()
//            )
//        }
//    }

//    container.register(AuthManager.init(keychainStorage:refreshService:))
//        .as(AuthManager.self)
//        .as(AuthorizationChecker.self)
//        .as(CredentialsService.self)
//        .lifetime(.perRun(.strong))
}
