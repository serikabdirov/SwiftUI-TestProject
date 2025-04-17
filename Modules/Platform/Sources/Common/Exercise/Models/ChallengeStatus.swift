//
//  ChallengeStatus.swift
//  Platform
//
//  Created by Александр Болотов on 14.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//


import Foundation

public enum ChallengeStatus: String, CaseIterable, Codable {
    case notStarted = "not_started"
    case inProgress = "in_progress"
    case completed
}
