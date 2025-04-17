//
//  Formatters.swift
//  Core
//
//  Created by Серик Абдиров on 28.10.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation

public extension BinaryInteger {
    func currency() -> String {
        self.formatted(
            .currency(code: "RUB")
            .precision(.fractionLength(0))
            .locale(Locale(identifier: "RU_ru"))
        )
    }
}
