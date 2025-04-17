//
//  FormattesDIPart.swift
//  Platform
//
//  Created by Zart Arn on 06.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import DITranquillity
import Foundation
import Networking

class FormattersDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(DistanceFormatter.init(profile:))
            .as(DistanceFormatter.self)
            .lifetime(.perRun(.strong))
    }
}
