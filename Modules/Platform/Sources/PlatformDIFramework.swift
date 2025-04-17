//
//  PlatformDIFramework.swift
//
//  Created by Денис Кожухарь on 10.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity

public class PlatformDIFramework: DIFramework {
    public static func load(container: DIContainer) {
        container.append(part: NetworkingDIPart.self)
        container.append(part: CredentialsDIPart.self)
        container.append(part: ProfileManagerDIPart.self)
        container.append(part: LocationServiceDIPart.self)
        container.append(part: HealthServiceDIPart.self)
        container.append(part: WorkSheetManagerDIPart.self)
        container.append(part: FormattersDIPart.self)
        container.append(part: AccessManagerDIPart.self)
        container.append(part: SubscriprionManagerDIPart.self)
        container.append(part: ProfileBonusDIPart.self)
        container.append(part: PushManagerDIPart.self)
    }
}
