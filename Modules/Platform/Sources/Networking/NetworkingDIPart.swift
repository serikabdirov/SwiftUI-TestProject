//
//  NetworkingDIPart.swift
//
//  Created by Денис Кожухарь on 30.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import Foundation
import Networking
import Pulse

class NetworkingDIPart: DIPart {
    static func load(container: DIContainer) {
        
        // Event monitors
        container.register(AuthorizationErrorMonitor.init(handler:))
        
        #if DEBUG
            container.register { NetworkActivityLogger(level: .debug) }
                .lifetime(.perRun(.weak))
        #endif

        #if PULSE_LOGGING
            container.register { PulseLoggerEventMonitor(logger: NetworkLogger.sharedInternalLogger) }
        #endif

        // Adapters
        container.register(TimezoneRequestAdapter.init)
        container.register(AuthorizationRequestInterceptor.init)

        // ApiClient
        container.register { (container: DIContainer) in
            ApiClient(
                interceptor: Interceptor(
                    adapters: [
                        container.resolve() as TimezoneRequestAdapter,
                    ],
                    interceptors: [
                        container.resolve() as AuthorizationRequestInterceptor
                    ]
                ),
                eventMonitors: ([
                    container.resolve() as NetworkActivityLogger?,
                    container.resolve() as PulseLoggerEventMonitor?,
                ] as [EventMonitor?]).compactMap { $0 }
            )
        }
        .as(ApiClient.self, tag: ApiClientGeneral.self)
        .lifetime(.perRun(.strong))
        
        // ApiClient for RefreshToken
        container.register { (container: DIContainer) in
            ApiClient(
                interceptor: nil,
                eventMonitors: ([
                    container.resolve() as NetworkActivityLogger?,
                    container.resolve() as PulseLoggerEventMonitor?,
                    container.resolve() as AuthorizationErrorMonitor,
                ] as [EventMonitor?]).compactMap { $0 }
            )
        }
        .as(ApiClient.self, tag: ApiClientAuth.self)
        .lifetime(.perRun(.strong))
        
        // LocalStorage        
        container.register {
            LocalStorage.init()
        }
        .lifetime(.perRun(.strong))
    }
}

public enum ApiClientAuth {}
public enum ApiClientGeneral {}
