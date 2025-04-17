//
//  AccessManagerDIPart.swift
//  Platform
//
//  Created by Zart Arn on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DITranquillity

class AccessManagerDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(AccessManagerImpl.init(profileManager:subscriptionManager:router:))
            .as(AccessManager.self)
            .lifetime(.perRun(.strong))
    }
}
