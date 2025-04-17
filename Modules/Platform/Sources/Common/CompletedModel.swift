//
//  CompletedModel.swift
//  Platform
//
//  Created by Александр Болотов on 16.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import R

public enum CompletedModel {
    case exercise(title: String)
    case training(awardPoints: Int)
    case trainingPartially
    case challenge(awardPoints: Int)
    case challengePractice

    public var navigationTitle: String {
        switch self {
        case .exercise(let title):
            title
        case .training:
            RStrings.Ls.Training.Details.finished
        case .trainingPartially:
            RStrings.Ls.Training.Details.finished
        case .challenge:
            RStrings.Ls.Challenges.Finish.Challenge.title
        case .challengePractice:
            RStrings.Ls.Challenges.Finish.Practice.title
        }
    }

    public var title: String {
        switch self {
        case .exercise:
            RStrings.Ls.Exercise.Detail.Execution.Done.title
        case .training:
            RStrings.Ls.Training.Details.Finished.Title.full
        case .trainingPartially:
            RStrings.Ls.Training.Details.Finished.Title.partially
        case .challenge:
            RStrings.Ls.Challenges.Finish.Challenge.subtitle
        case .challengePractice:
            RStrings.Ls.Challenges.Finish.Practice.subtitle

        }
    }

    public var subtitle: String {
        switch self {
        case .exercise:
            RStrings.Ls.Exercise.Detail.Execution.Done.body
        case let .training(awardPoints):
            RStrings.Plurals.Training.Details.Finished.Body
                .full(awardPoints)
        case .trainingPartially:
            RStrings.Ls.Training.Details.Finished.Body.partially
        case let .challenge(awardPoints):
            RStrings.Plurals.Challenges.Finish.Challenge.body(awardPoints)
        case .challengePractice:
            RStrings.Ls.Challenges.Finish.Practice.body
        }
    }
}
