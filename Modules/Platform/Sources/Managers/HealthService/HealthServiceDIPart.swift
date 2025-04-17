//
//  HealthServiceDIPart.swift
//  Platform
//
//  Created by Александр Болотов on 02.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DITranquillity

class HealthServiceDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(HealthServiceImpl.init)
            .as(HealthService.self)
            .lifetime(.perRun(.strong))
    }
}
