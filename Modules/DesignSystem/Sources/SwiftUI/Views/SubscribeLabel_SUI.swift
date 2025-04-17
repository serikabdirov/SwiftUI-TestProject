//
//  StatusChipDataModelProtocol.swift
//  DesignSystem
//
//  Created by Александр Болотов on 19.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct SubscribeLabel_SUI: View {
    private let status: Status

    public init(_ status: Status) {
        self.status = status
    }

    public var body: some View {
        Text(status.title)
            .font(UIFont.helperMed.swiftUIFont)
            .foregroundStyle(status.foregroundColor)
            .padding(.vertical, DS.Gap.XS)
            .padding(.horizontal, DS.Gap.S)
            .background(status.backgroundColor)
            .clipShape(.rect(cornerRadius: 32))
    }
}

public extension SubscribeLabel_SUI {
    enum Status {
        case active
        case waitingPayment
        case notExtended

        var title: String {
            switch self {
            case .active:
                RStrings.Ls.Subscription.Main.Status.active
            case .waitingPayment:
                RStrings.Ls.Subscription.Main.Status.pending
            case .notExtended:
                RStrings.Ls.Subscription.Main.Status.expiring
            }
        }

        var foregroundColor: Color {
            switch self {
            case .active:
                UIColor.Text.white.swiftUIColor
            case .waitingPayment:
                UIColor.Additional.purple2.swiftUIColor
            case .notExtended:
                UIColor.Main.red1.swiftUIColor
            }
        }

        var backgroundColor: Color {
            switch self {
            case .active:
                UIColor.Green._80.swiftUIColor
            case .waitingPayment:
                UIColor.Additional.lightPurple2.swiftUIColor
            case .notExtended:
                UIColor.Additional.lightRed.swiftUIColor
            }
        }
    }
}

#Preview {
    SubscribeLabel_SUI(.active)
}
