//
//  TrainingReport.swift
//  Exercise
//
//  Created by Серик Абдиров on 12.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public struct TrainingReport: Codable {
    public let status: Status
    public let exercises: [ExerciseReport]
    
    public init(status: Status, exercises: [ExerciseReport]) {
        self.status = status
        self.exercises = exercises
    }
}
