//
//  ApiErrorModel.swift
//  Platform
//
//  Created by Zart Arn on 12.09.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Networking

public struct ApiErrorModel: Decodable {
    /// HTTP response status code
    public var httpStatusCode: Int?

    /// Error code
    public let code: String?

    /// User-friendly error description
    public let message: String?
    
    /// payload data
    public var payload: [String: Any]?

    public enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    
    public func decodePayload<T: Decodable>() throws -> T {
        try decodePayload(valueType: T.self)
    }
    
    public func decodePayload<T: Decodable>(valueType: T.Type) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: (payload ?? []), options: [.fragmentsAllowed])
        let decoder = JSONDecoder().then {
            $0.keyDecodingStrategy = .convertFromSnakeCase
        }
        let object = try decoder.decode(T.self, from: jsonData)
        return object        
    }
}

// MARK: - LocalizedError

extension ApiErrorModel: LocalizedError {
    public var errorDescription: String? {
        message
    }
}

// MARK: - ComposableError

extension ApiErrorModel: ComposableError {
    public var underlyingComposableError: ComposableError? {
        nil
    }

    public var identifiableCode: String {
        "BALL_API-\(code ?? "empty")"
    }
}
