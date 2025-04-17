//
//  StartEvent.swift
//  Platform
//
//  Created by Vladislav on 27.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//
import Foundation

public struct StartEvent: Codable {
    public let id: String
    public let location: Location?
    public let photoResult: String?
}

public struct Location: Codable {
    public let longitude: Double?
    public let latitude: Double?
}
