//
//  AuthorizationErrorMonitor.swift
//  Platform
//
//  Created by Денис Кожухарь on 06.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Alamofire
import Foundation

public protocol AuthorizationErrorMonitorHandler {
    func authorizationErrorOccurred()
}

final class AuthorizationErrorMonitor: EventMonitor {
    // MARK: - Private properties

    private let handler: AuthorizationErrorMonitorHandler

    // MARK: - Init

    init(handler: AuthorizationErrorMonitorHandler) {
        self.handler = handler
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if (dataTask.response as? HTTPURLResponse)?.statusCode == 401 {
            handler.authorizationErrorOccurred()
        }
    }
}
