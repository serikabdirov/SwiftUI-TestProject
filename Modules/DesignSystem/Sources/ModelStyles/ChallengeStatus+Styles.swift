//
//  ChallengeStatus+Styles.swift
//  DesignSystem
//
//  Created by Nikita Ziganshin on 31.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Platform
import R
import SwiftUICore

extension ChallengeEntityStatus: StatusChipDataModelProtocol {
    public var title: String {
        switch self {
        case .created:
            RStrings.Ls.Challenges.List.Status.created
        case .onModeration:
            RStrings.Ls.Challenges.List.Status.moderation
        case .published:
            RStrings.Ls.Challenges.List.Status.published
        case .rejected:
            RStrings.Ls.Challenges.List.Status.declined
        case .running:
            RStrings.Ls.Challenges.List.Status.launched
        case .completed:
            RStrings.Ls.Challenges.List.Status.completed
        }
    }

    public var foregroundColor: Color {
        switch self {
        case .created:
            UIColor.Additional.blue1.swiftUIColor

        case .onModeration:
            UIColor.Additional.purple2.swiftUIColor

        case .published:
            UIColor.Green._30.swiftUIColor

        case .rejected:
            UIColor.Main.red1.swiftUIColor

        case .running:
            UIColor.Text.white.swiftUIColor

        case .completed:
            UIColor.Green._30.swiftUIColor
        }
    }

    public var backgroundColor: Color {
        switch self {
        case .created:
            UIColor.Additional.lightBlue.swiftUIColor
        case .onModeration:
            UIColor.Additional.lightPurple2.swiftUIColor
        case .published:
            UIColor.Green._105.swiftUIColor
        case .rejected:
            UIColor.Additional.lightRed.swiftUIColor
        case .running:
            UIColor.Green._70.swiftUIColor
        case .completed:
            UIColor.Green._105.swiftUIColor
        }
    }
}

extension ChallengeStatus: StatusChipDataModelProtocol {
    public var title: String {
        switch self {
        case .notStarted:
            RStrings.Ls.Challenges.List.Userstatus.notstarted
        case .inProgress:
            RStrings.Ls.Challenges.List.Userstatus.inprocess
        case .completed:
            RStrings.Ls.Challenges.List.Userstatus.finished
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
