//
//  SubscriprionManagerDIPart.swift
//  Platform
//
//  Created by Zart Arn on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DITranquillity
import Networking

class SubscriprionManagerDIPart: DIPart {
    static func load(container: DIContainer) {
        
        container.register(IAPManager.init)
        
        container.register {
            SubscriptionManagerServiceImpl.init(
                apiClient: by(tag: ApiClientGeneral.self, on: $0),
                errorTranslator: ErrorTranslators.unspecifiedDomainErrorTranslator()
                    .eraseToAnyErrorTranslator()
            )
        }
        .as(SubscriptionManagerService.self)
        
        container.register(SubscriptionManagerImpl.init(service:iapManager:))
            .as(SubscriptionManager.self)
            .lifetime(.perRun(.strong))
    }
}
