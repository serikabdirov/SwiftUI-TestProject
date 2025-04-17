//
//  DomainError.swift
//  Core
//
//  Created by Денис Кожухарь on 29.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Core
import Foundation

public struct DomainError<ErrorCode>: ComposableError {
    // MARK: - Public properties

    public var identifiableCode: String {
        String(describing: code)
    }

    public var underlyingComposableError: ComposableError?

    public let code: ErrorCode
    public let message: String
    public var payload: [String: Any]?

    // MARK: - Init

    public init(
        code: ErrorCode,
        message: String,
        underlyingComposableError: ComposableError?,
        payload: [String: Any]? = nil
    ) {
        self.code = code
        self.message = message
        self.underlyingComposableError = underlyingComposableError
        self.payload = payload
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

extension DomainError: LocalizedError {
    public var errorDescription: String? {
        message
    }
}

// MARK: - UnspecifiedDomainError

public enum UnspecifiedDomainErrorCode: String {
    case unknown
}

public typealias UnspecifiedDomainError = DomainError<UnspecifiedDomainErrorCode>
