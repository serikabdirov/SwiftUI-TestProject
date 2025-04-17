//
//  Exercise+Styles.swift
//  DesignSystem
//
//  Created by Zart Arn on 18.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Platform
import R
import SwiftUICore

extension ExerciseStatus: StatusChipDataModelProtocol {
    public var title: String {
        switch self {
        case .completed:
            RStrings.Ls.Exercise.Detail.isCompleted
        case .notCompleted:
            RStrings.Ls.Exercise.Detail.notCompleted
        }
    }

    public var foregroundColor: Color {
        switch self {
        case .completed:
            UIColor.Text.main.swiftUIColor
        case .notCompleted:
            UIColor.Additional.blue1.swiftUIColor
        }
    }

    public var backgroundColor: Color {
        switch self {
        case .completed:
            UIColor.Additional.lightBlue.swiftUIColor
        case .notCompleted:
            UIColor.Additional.lightBlue.swiftUIColor
        }
    }
}

public extension Exercise {
    var descriptionString: String {
        if let repetitions {
            RStrings.Ls.Training.Details.Exercise.content(numberOfApproaches, repetitions)
        } else if let approachTime {
            if (numberOfApproaches * approachTime) % 60 == 0 {
                "\((numberOfApproaches * approachTime) / 60) \(RStrings.Ls.Training.Details.Exercises.List.Time.minute)"
            } else {
                "~\(((numberOfApproaches * approachTime) + 59) / 60) \(RStrings.Ls.Training.Details.Exercises.List.Time.minute)"
            }
        } else {
            ""
        }
    }
}
