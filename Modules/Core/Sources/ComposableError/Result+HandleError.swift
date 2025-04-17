//
//  Untitled.swift
//  Core
//
//  Created by Zart Arn on 24.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public extension Result {
    func translateError(using translator: any ErrorTranslatorProtocol) -> Result<Success, Error> {
        mapError { translator.translate(from: $0) }
    }
}
