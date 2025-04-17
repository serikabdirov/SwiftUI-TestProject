//
//  PulseLoggerEventMonitor.swift
//  Platform
//
//  Created by Серик Абдиров on 21.08.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import Alamofire
import Foundation
#if PULSE_LOGGING
    import Pulse

    struct PulseLoggerEventMonitor: EventMonitor {
        private let logger: NetworkLogger

        init(logger: NetworkLogger) {
            self.logger = logger
        }

        func request(_ request: Request, didCreateTask task: URLSessionTask) {
            logger.logTaskCreated(task)
        }

        func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
            logger.logDataTask(dataTask, didReceive: data)
        }

        func urlSession(
            _ session: URLSession,
            task: URLSessionTask,
            didFinishCollecting metrics: URLSessionTaskMetrics
        ) {
            logger.logTask(task, didFinishCollecting: metrics)
        }

        func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
            guard let task = request.lastTask else { return }
            let decodingError = response.error?
                .traverseUnderlying(searching: DecodingError.self)
                .map { NetworkLogger.DecodingError(adaptingPathFrom: $0) }
            let error: Error? = decodingError ??
                response.error?.underlyingError ??
                response.error
            logger.logTask(task, didFinishDecodingWithError: error)
        }
    }

    extension NetworkLogger {
        static var sharedInternalLogger = NetworkLogger(configuration: Configuration())
    }

    private extension NetworkLogger.DecodingError {
        init(adaptingPathFrom error: DecodingError) {
            let tempError = NetworkLogger.DecodingError(error)
            if var adaptedContext = tempError.context {
                adaptedContext.codingPath = adaptedContext.codingPath.map { key in
                    switch key {
                    case .int:
                        return key
                    case let .string(string):
                        return .string(string.snakeCased ?? string)
                    }
                }
                switch tempError {
                case let .typeMismatch(type, _):
                    self = .typeMismatch(type: type, context: adaptedContext)
                case let .valueNotFound(type, _):
                    self = .valueNotFound(type: type, context: adaptedContext)
                case let .keyNotFound(codingKey, _):
                    self = .keyNotFound(codingKey: codingKey, context: adaptedContext)
                case .dataCorrupted:
                    self = .dataCorrupted(context: adaptedContext)
                case .unknown:
                    self = .unknown
                }
            } else {
                self = tempError
            }
        }
    }

    private extension String {
        var snakeCased: String? {
            let pattern = "([a-z0-9])([A-Z])"
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: count)
            return regex?
                .stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
                .lowercased()
        }
    }
#else
    struct PulseLoggerEventMonitor: EventMonitor {}
#endif
