//
//  LinkManager.swift
//  Platform
//
//  Created by Zart Arn on 11.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public protocol LinkHandler {
    func handleLink(link: DeepLink) -> Bool
}

public final class LinkManager {
    private let handlersRegistry: LinkHandlersRegistry
    private var isAppReady = false
    private var pendingPath: String?

    init(handlersRegistry: LinkHandlersRegistry) {
        self.handlersRegistry = handlersRegistry
    }

    public func setAppReady() {
        isAppReady = true
        if let path = pendingPath {
            _ = handlersRegistry.handle(with: path)
            pendingPath = nil
        }
    }
    
    public func handle(with path: String) {
        guard isAppReady else {
            pendingPath = path
            return
        }
        _ = handlersRegistry.handle(with: path)
    }
}

public enum LinkEvent: String {
    case courses
    case profile
    case unknown
}

public struct DeepLink {
    public let event: LinkEvent
    public let queryItems: [String: String]
    public let rawPath: String
    
    init?(url: URL) {
        self.rawPath = url.path
        
        // Берем первый компонент пути
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        guard let first = pathComponents.first,
              let event = LinkEvent(rawValue: first) else {
            self.event = .unknown
            self.queryItems = [:]
            return
        }
        
        self.event = event

        // Парсим query параметры
        var items: [String: String] = [:]
        
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                if let value = item.value?.removingPercentEncoding {
                    items[item.name] = value
                }
            }
        }
        self.queryItems = items
    }
}
