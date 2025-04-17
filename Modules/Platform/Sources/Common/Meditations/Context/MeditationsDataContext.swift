//
//  MeditationsDataContext.swift
//  Meditations
//
//  Created by Nikita Ziganshin on 27.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

public struct MeditationsDataContext {
    public let meditations: MeditationList
    public init(meditations: MeditationList) {
        self.meditations = meditations
    }
}
