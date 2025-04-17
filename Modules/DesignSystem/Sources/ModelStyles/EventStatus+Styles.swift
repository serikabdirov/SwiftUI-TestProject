//
//  EventStatus+Styles.swift
//  DesignSystem
//
//  Created by Vladislav on 25.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Platform
import R
import SwiftUICore

extension EventStatus: StatusChipDataModelProtocol {
    
    public var title: String {
        switch self {
        case .notStarted:
            RStrings.Ls.Events.Detail.User.Participation.Not.started
        case .inProgress:
            RStrings.Ls.Events.Detail.User.Participation.In.process
        case .completed:
            RStrings.Ls.Events.Detail.User.Participation.finished
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

extension EventDetail.EventStatus: StatusChipDataModelProtocol {
    public var title: String {
        switch self {
        case .notStarted:
            RStrings.Ls.Events.Detail.User.Participation.Not.started
        case .inProgress:
            RStrings.Ls.Events.Detail.User.Participation.In.process
        case .completed:
            RStrings.Ls.Events.Detail.User.Participation.finished
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
