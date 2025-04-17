//
//  DataResponse+KiMapping.swift
//  BallApp
//
//  Created by Zart Arn on 12.09.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Networking

public extension Mappings {
    static func ballDecodable<Value: Decodable>(_ type: Value.Type) -> Mapping<Value> {
        Mappings.decodable(
            type,
            atKeyPath: nil,
            using: JSONDecoder().then {
                $0.keyDecodingStrategy = .convertFromSnakeCase
            }
        )
    }

    static func ballErrorMapper() -> Mapping<ApiErrorModel> {
        { input in
            let data = try input.result.get()
            let rawError = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]

            
            var apiError = try Mappings.decodable(
                ApiErrorModel.self,
                atKeyPath: nil,
                using: JSONDecoder().then {
                    $0.keyDecodingStrategy = .convertFromSnakeCase
                }
            )(input)
            
            apiError.httpStatusCode = input.response?.statusCode
            apiError.payload = rawError?["payload"] as? [String: Any]
            
            return apiError
        }
    }
}

public extension ResponseSerializer {
    
    static func ballResponseSerializer<Value: Decodable>(
        valueType: Value.Type
    ) -> MappingStrategyResponseSerializer<Value, ApiErrorModel>
        where Self == MappingStrategyResponseSerializer<Value, ApiErrorModel>
    {
        .strategySerializer(
            valueMapping: Mappings.ballDecodable(Value.self),
            errorMapping: Mappings.ballErrorMapper(),
            mappingStrategy: MappingStrategies.statusResponse()
        )
    }
    
    static func ballResponseSerializer<Value: Decodable>() -> MappingStrategyResponseSerializer<Value, ApiErrorModel>
        where Self == MappingStrategyResponseSerializer<Value, ApiErrorModel>
    {
        ballResponseSerializer(valueType: Value.self)
    }

    static func ballEmptyResponseSerializer() -> MappingStrategyResponseSerializer<Void, ApiErrorModel>
        where Self == MappingStrategyResponseSerializer<Void, ApiErrorModel>
    {
        .strategySerializer(
            valueMapping: { _ in () },
            errorMapping: Mappings.ballErrorMapper(),
            mappingStrategy: MappingStrategies.statusResponse()
        )
    }
}
