//
//  EventsService.swift
//  Platform
//
//  Created by Vladislav on 24.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol EventsService {
    func getEventDetails(id: Int) async throws -> EventDetail
    func getEventsList(request: EventsRequest) async throws -> EventsList
    func startEvent(id: Int) async throws -> StartEvent
    func confirmPhoto(id: String, imageData: Data) async throws -> PhotoResponse
    func confirmLocation(id: String, location: EventLocationRequest) async throws -> EventLocationResponse
}
