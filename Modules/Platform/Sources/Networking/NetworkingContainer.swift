//
//  NetworkingContainer.swift
//  Platform
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Factory
import Networking
import Pulse

public final class NetworkingContainer: SharedContainer {
    @TaskLocal
    public static var shared = NetworkingContainer()
    public let manager = ContainerManager()
}

public extension NetworkingContainer {
    var pulseLogger: Factory<EventMonitor?> {
        #if PULSE_LOGGING
            self { PulseLoggerEventMonitor(logger: NetworkLogger.sharedInternalLogger) }
        #else
            self { nil }
        #endif
    }

    var networkActivityLogger: Factory<EventMonitor?> {
        #if DEBUG
            self { NetworkActivityLogger(level: .debug) }.singleton
        #else
            self { nil }
        #endif
    }

    var eventMonitors: Factory<[EventMonitor]> {
        self {
            [
                self.pulseLogger(),
                self.networkActivityLogger()
            ].compactMap { $0 }
        }
    }

    var apiClient: Factory<ApiClient> {
        self {
            ApiClient(
                interceptor: nil,
                eventMonitors: self.eventMonitors()
            )
        }
        .singleton
    }
}
