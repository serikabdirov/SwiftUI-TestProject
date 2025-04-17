//
//  EventLocationResponse.swift
//  Platform
//
//  Created by Vladislav on 01.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

public struct EventLocationResponse: Codable {
    public let longitude: Double?
    public let latitude: Double?
    
    public init(longitude: Double?, latitude: Double?) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
