//
//  Request.swift
//  Events
//
//  Created by Vladislav on 25.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

public struct EventsRequest: Codable {
    public let eventType: EventType?
    public let eventStatus: EventStatus?
    
    public init(eventType: EventType?, eventStatus: EventStatus?) {
        self.eventType = eventType
        self.eventStatus = eventStatus
    }
}
