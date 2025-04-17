//
//  EventsList.swift
//  Platform
//
//  Created by Vladislav on 24.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable
import Foundation

public typealias EventsList = [EventsElementList]

public struct EventsElementList: Codable {
    public let id: Int
    public let eventType: EventType
    public let name: String
    
    @DateValue<ISO8601Strategy>
    public var startDate: Date
    
    @DateValue<ISO8601Strategy>
    public var endDate: Date
    
    public let cover: URL?
    public let status: EventStatus
    public let multiplier: Multiplier
}

public enum EventStatus: String, CaseIterable, Codable {
    case notStarted = "not_started"
    case inProgress = "in_progress"
    case completed
}

public enum EventType: String, Codable {
    case performingActions = "performing_actions"
    case placeVisiting = "place_visiting"
}

public struct Multiplier: Codable {
    public let name: String
    public let value: Double
    public let duration: String
}

public extension EventsList {
    static let mockList: EventsList = [
        .init(id: 1, eventType: .performingActions, name: "Title", startDate: Date(), endDate: Date(), cover: nil, status: .completed, multiplier: .init(name: "", value: 1, duration: "")),
        .init(id: 1, eventType: .performingActions, name: "Title", startDate: Date(), endDate: Date(), cover: nil, status: .notStarted, multiplier: .init(name: "", value: 1, duration: ""))
    ]
}
