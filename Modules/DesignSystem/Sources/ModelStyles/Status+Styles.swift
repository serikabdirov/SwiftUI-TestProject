//
//  Status+Styles.swift
//  DesignSystem
//
//  Created by Zart Arn on 18.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Platform
import R
import SwiftUICore

extension Status: StatusChipDataModelProtocol {

    public var title: String {
        switch self {
        case .notStarted:
            RStrings.Ls.Training.Common.Status.Not.started
        case .inProgress:
            RStrings.Ls.Training.Common.Status.started
        case .completed:
            RStrings.Ls.Training.Common.Status.done
        }
    }

    public var foregroundColor: Color {
        switch self {
        case .notStarted:
            UIColor.Additional.blue1.swiftUIColor
        case .inProgress:
            UIColor.Additional.orange3.swiftUIColor
        case .completed:
            UIColor.Green._30.swiftUIColor
        }
    }

    public var backgroundColor: Color {
        switch self {
        case .notStarted:
            UIColor.Additional.lightBlue.swiftUIColor
        case .inProgress:
            UIColor.Additional.lightOrange3.swiftUIColor
        case .completed:
            UIColor.Green._105.swiftUIColor
        }
    }
}
