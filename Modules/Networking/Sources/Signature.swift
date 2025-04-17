//
//  Signature.swift
//  Networking
//
//  Created by Vladislav on 08.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import CryptoKit

public struct Signature {
    
    public let timestamp: String
    public let signature: String
    
    public init(phone: String) {
        let timestamp: String = "\(Date().timeIntervalSince1970)"
        self.init(timestamp: timestamp, signature: Self.signature(timestamp: timestamp, phone: phone))
    }
    
    public init(timestamp: String, signature: String) {
        self.timestamp = timestamp
        self.signature = signature
    }
    
    private static let secretKey = "secret-key"
    
    private static func signature(timestamp: String, phone: String) -> String {
        
        let key = SymmetricKey(data: Data(secretKey.utf8))
        let string = "\(timestamp):\(phone)"
        let authenticationCode = HMAC<SHA256>.authenticationCode(for: Data(string.utf8), using: key)
        let signature = Data(authenticationCode).base64EncodedString()
        
        return signature
        
    }
}
