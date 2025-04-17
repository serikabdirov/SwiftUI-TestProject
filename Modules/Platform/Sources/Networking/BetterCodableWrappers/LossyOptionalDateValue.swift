//
//  LossyOptionalDateValue.swift
//  Platform
//
//  Created by Денис Кожухарь on 29.09.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

@_exported import BetterCodable
import Foundation

@propertyWrapper
public struct LossyOptionalDateValue<Formatter: DateValueCodableStrategy> {
    private let value: Formatter.RawValue?
    public var wrappedValue: Date?

    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
        self.value = wrappedValue.map(Formatter.encode)
    }
}

extension LossyOptionalDateValue: Decodable where Formatter.RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        self.value = try Formatter.RawValue(from: decoder)
        if let value = value {
            self.wrappedValue = try Formatter.decode(value)
        } else {
            self.wrappedValue = nil
        }
    }
}

extension LossyOptionalDateValue: Encodable where Formatter.RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

extension LossyOptionalDateValue: Equatable, Hashable {
    public static func == (lhs: LossyOptionalDateValue<Formatter>, rhs: LossyOptionalDateValue<Formatter>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}
