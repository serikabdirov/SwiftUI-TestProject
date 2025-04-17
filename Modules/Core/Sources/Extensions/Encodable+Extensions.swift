//
//  Encodable+Extensions.swift
//  Core
//

import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder
            .convertingToSnakeCase
            .encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return dict
    }
}
