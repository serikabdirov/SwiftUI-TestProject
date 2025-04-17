//
//  WorkSheetManagerDIPart.swift
//  Platform
//
//  Created by Евграфов Максим on 12.11.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import DITranquillity
import Foundation
import Networking

class WorkSheetManagerDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register {
            WorkSheetManagerServiceImpl(
                apiClient: by(tag: ApiClientGeneral.self, on: $0),
                errorTranslator: ErrorTranslators.unspecifiedDomainErrorTranslator()
                    .eraseToAnyErrorTranslator()
            )
        }
        .as(WorkSheetManagerService.self)
    }
}
