//
//  PracticeDetail.swift
//  Courses
//
//  Created by Серик Абдиров on 07.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable

public typealias PracticesList = [PracticeDetail]

public struct PracticeDetail: Identifiable, Codable {
    public let id: Int
    public let recordId: Int?
    public let status: Status
    public let title: String
    public let icon: URL?
    @OptionalDateValue<ISO8601Strategy>
    public var plannedDate: Date?
}
