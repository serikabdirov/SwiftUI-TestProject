//
//  Status.swift
//  Exercise
//
//  Created by Серик Абдиров on 06.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public enum Status: String, CaseIterable, Codable {
    case notStarted = "not_started"
    case inProgress = "in_progress"
    case completed
}
