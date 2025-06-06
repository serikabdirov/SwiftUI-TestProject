import Foundation

/// Allows to convert error type
/// * `ToError` - Source error type
/// * `ExpectedError` - Result error type
public protocol ErrorTranslatorProtocol {
    associatedtype ToError: ComposableError
    associatedtype ExpectedError: ComposableError

    /// Translates error type
    func translate(from error: Swift.Error) -> ToError
}

public enum ErrorTranslators {}

public extension ErrorTranslatorProtocol {
    func eraseToAnyErrorTranslator() -> AnyErrorTranslator<ExpectedError, ToError> {
        AnyErrorTranslator(self)
    }
}
