//
//  MappingStrategies+ErrorModel.swift
//  Platform
//
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Networking

public extension MappingStrategies {
    /// `MappingStrategy` that handles responses
    static func statusResponse<Value, Error: Swift.Error>() -> MappingStrategy<Value, Error> {
        { input, valueMapping, errorMapping in
            #if MOCK
                let isSuccessfulCode = true
            #else
                let isSuccessfulCode = (200 ..< 300).contains(input.response?.statusCode ?? 0)
            #endif
            if isSuccessfulCode {
                return try valueMapping(input)
            } else {
                throw try errorMapping(input)
            }
        }
    }
}
