//
//  ValidationError.swift
//

import Foundation

public struct ValidationError: LocalizedError {
    private var message: String
    
    public init(message: String) {
        self.message = message
    }
    public var errorDescription: String? {
        message
    }
}
