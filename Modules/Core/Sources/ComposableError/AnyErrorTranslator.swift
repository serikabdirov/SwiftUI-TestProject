//
//  AnyErrorTranslator.swift
//  network-playground
//
//  Created by Денис Кожухарь on 22.07.2022.
//

import Foundation

public struct AnyErrorTranslator<ExpectedError: ComposableError, ToError: ComposableError>: ErrorTranslatorProtocol {
    private let base: Any?

    private let capturedTranslate: (Swift.Error) -> ToError

    public init<Base: ErrorTranslatorProtocol>(_ base: Base)
        where
        Base.ExpectedError == ExpectedError,
        Base.ToError == ToError
    {
        self.base = base
        self.capturedTranslate = base.translate
    }

    public func translate(from error: Swift.Error) -> ToError {
        capturedTranslate(error)
    }
}
