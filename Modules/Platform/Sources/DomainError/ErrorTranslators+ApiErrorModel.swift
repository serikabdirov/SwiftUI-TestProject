//
//  ErrorTranslators+ApiErrorModel.swift
//  Platform
//
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation
import Networking
import R

public extension ErrorTranslators {
    final class ErrorTranslator<DomainErrorCode>: ErrorTranslatorProtocol
        where
        DomainErrorCode: RawRepresentable,
        DomainErrorCode.RawValue == String
    {
        public typealias ToError = DomainError<DomainErrorCode>
        public typealias ExpectedError = ApiErrorModel

        public let defaultCode: DomainErrorCode
        public let defaultMessage: String

        public init(
            defaultCode: DomainErrorCode,
            defaultMessage: String
        ) {
            self.defaultCode = defaultCode
            self.defaultMessage = defaultMessage
        }

        public func translate(from error: Error) -> DomainError<DomainErrorCode> {
            #if DEBUG
                print(error)
            #endif
            guard
                let composableError = (error as? ComposableError),
                let apiError = composableError.traverseUnderlying(searching: ApiErrorModel.self)
            else {
                return DomainError(
                    code: defaultCode,
                    message: localizedMessage(for: error) ?? defaultMessage,
                    underlyingComposableError: error as? ComposableError
                )
            }
            
            let code = apiError.code
            return DomainError(
                code: code.map { DomainErrorCode(rawValue: $0) ?? defaultCode } ?? defaultCode,
                message: apiError.errorDescription ?? defaultMessage,
                underlyingComposableError: apiError,
                payload: apiError.payload
            )
        }

        // MARK: - Private methods

        private func localizedMessage(for error: Error) -> String? {
            if let localizedError = error.asAFError?.underlyingError as? LocalizedError {
                return localizedError.localizedDescription
            } else if let nsError = error.asAFError?.underlyingError as? NSError,
                      let localizedDescription = nsError.userInfo[NSLocalizedDescriptionKey] as? String
            {
                return localizedDescription
            } else {
                return nil
            }
        }
    }
}

// MARK: - Some Translators

public extension ErrorTranslators {
    static func unspecifiedDomainErrorTranslator() -> ErrorTranslator<UnspecifiedDomainErrorCode> {
        ErrorTranslator<UnspecifiedDomainErrorCode>(
            defaultCode: .unknown,
            defaultMessage: RStrings.Ls.Common.Error.Something.Went.wrong
        )
    }
}
