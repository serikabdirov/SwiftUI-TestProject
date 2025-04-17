//
//  TrainigsList.swift
//  Exercise
//
//  Created by Серик Абдиров on 05.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import BetterCodable
import Foundation
import R

public typealias TrainigsList = [TrainigsListElement]

public struct TrainigsListElement: Codable, Identifiable {
    public let id: Int
    public let recordId: Int?
    public let title: String
    public let level: Level
    public let icon: URL?
    public let uid: Int?
    public let status: Status?
    public let awardPoints: Int
    public let awardedPoints: Int
    public let numberOfExercises: Int
    public let completedExercises: Int
    public let trainingScheduleId: Int?
    @OptionalDateValue<ISO8601Strategy>
    public var nextTrainingDate: Date?
}
