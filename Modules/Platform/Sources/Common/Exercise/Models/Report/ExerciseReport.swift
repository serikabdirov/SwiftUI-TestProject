//
//  ExerciseReport.swift
//  Exercise
//
//  Created by Серик Абдиров on 12.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import BetterCodable

public struct ExerciseReport: Codable {
    public let recordId: Int?
    public let status: ExerciseStatus
    @DateValue<ISO8601Strategy>
    public var startedAt: Date
    @DateValue<ISO8601Strategy>
    public var completedAt: Date
    
    public init(recordId: Int?, status: ExerciseStatus, startedAt: Date, completedAt: Date) {
        self.recordId = recordId
        self.status = status
        self.startedAt = startedAt
        self.completedAt = completedAt
    }
}
