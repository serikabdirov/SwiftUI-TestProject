//
//  PushHandlersRegistry.swift
//  Platform
//
//  Created by Zart Arn on 10.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import UserNotifications

public final class LinkHandlersRegistry {
    
    private var handlers: [any LinkHandler]
    
    init(handlers: [any LinkHandler]) {
        self.handlers = handlers
    }
    
    // MARK: - Public methods

    public func register(handler: some LinkHandler) {
        handlers.append(handler)
    }
    
    public func handle(with path: String) -> Bool {
        guard let url = URL(string: path), let link = DeepLink(url: url) else {
            return false
        }
        for handler in handlers where handler.handleLink(link: link) == true {
            return true
        }
        return false
    }
}
