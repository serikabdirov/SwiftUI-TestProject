//
//  LocationServiceDIPart.swift
//  Platform
//
//  Created by Александр Болотов on 05.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import CoreLocation
import DITranquillity
import Foundation

class LocationServiceDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(LocationServiceImpl.init)
            .as(LocationService.self)
            .lifetime(.perRun(.strong))
    }
}
