//
//  ApiVersionErrorMonitor.swift
//  Platform
//
//  Created by Денис Кожухарь on 07.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Alamofire
import Foundation

public protocol ApiVersionErrorMonitorHandler {
    func apiVersionErrorOccurred()
}

final class ApiVersionErrorMonitor: EventMonitor {
    // MARK: - Private properties

    private let handler: ApiVersionErrorMonitorHandler

    // MARK: - Init

    init(handler: ApiVersionErrorMonitorHandler) {
        self.handler = handler
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if (dataTask.response as? HTTPURLResponse)?.statusCode == 406 {
            handler.apiVersionErrorOccurred()
        }
    }
}
