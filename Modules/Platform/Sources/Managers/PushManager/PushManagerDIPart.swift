//
//  PushManagerDIPart.swift
//  Platform
//
//  Created by Zart Arn on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DITranquillity

public class PushManagerDIPart: DIPart {
    public static func load(container: DIContainer) {
        
        container.register {
            PushServiceImpl.init(
                apiClient: by(tag: ApiClientGeneral.self, on: $0)
            )
        }
        .as(PushService.self)
        
        container.register(PushManager.init(service:authorizationChecker:linkManager:))
            .lifetime(.perRun(.strong))
        
        container.register {
            LinkHandlersRegistry(handlers: many($0))
        }
        
        container.register(LinkManager.init(handlersRegistry:))
    }
}
