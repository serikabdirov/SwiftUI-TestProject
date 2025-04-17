//
//  ChipView.swift
//  Exercise
//
//  Created by Серик Абдиров on 04.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct DefaultChip_SUI: View {
    private let dataModel: DataModel
    private let size: Size

    public init(_ dataModel: DataModel, size: Size) {
        self.dataModel = dataModel
        self.size = size
    }

    public var body: some View {
        HStack(spacing: 4) {
            dataModel.icon
                .resizable()
                .frame(width: size.iconSize, height: size.iconSize)
            Text(dataModel.title)
                .font(size.font)
                .foregroundStyle(dataModel.type.foregroundColor)
        }
        .padding(size.insets)
        .frame(height: size.height)
        .background(dataModel.type.backgroundColor)
        .clipShape(.rect(cornerRadius: size.cornerRadius))
    }
}

public extension DefaultChip_SUI {
    struct DataModel: Hashable, Equatable {
        let icon: Image
        let title: String
        let type: ChipType

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }

        public init(icon: Image, title: String, type: ChipType) {
            self.icon = icon
            self.title = title
            self.type = type
        }
    }
}

public extension DefaultChip_SUI {
    enum Size {
        case M
        case S
        case XS

        var height: CGFloat {
            switch self {
            case .M: 28
            case .S: 28
            case .XS: 18
            }
        }

        var font: Font {
            switch self {
            case .M: UIFont.body2Reg.swiftUIFont
            case .S: UIFont.captionReg.swiftUIFont
            case .XS: UIFont.helperReg.swiftUIFont
            }
        }

        var cornerRadius: CGFloat { DesignSystem.Corner.XL }

        var iconSize: CGFloat {
            switch self {
            case .M:
                24
            case .S:
                16
            case .XS:
                12
            }
        }

        var insets: EdgeInsets {
            switch self {
            case .M:
                EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 10)
            case .S:
                EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 12)
            case .XS:
                EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 10)
            }
        }
    }

    enum ChipType: CaseIterable {
        case `default`
        case defaultDone
        case defaultDisabled

        var foregroundColor: Color {
            switch self {
            case .default:
                UIColor.Text.main.swiftUIColor
            case .defaultDone:
                UIColor.Text.white.swiftUIColor
            case .defaultDisabled:
                UIColor.Text.disabled.swiftUIColor
            }
        }

        var backgroundColor: Color {
            switch self {
            case .default:
                UIColor.Green._105.swiftUIColor
            case .defaultDone:
                UIColor.Green._70.swiftUIColor
            case .defaultDisabled:
                UIColor.Green._105.swiftUIColor
            }
        }

        static func random() -> Self {
            allCases.randomElement()!
        }
    }
}

public extension DefaultChip_SUI.DataModel {
    static let test = [
        DefaultChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "long string",
            type: .random()
        ),
        DefaultChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "short",
            type: .random()
        ),
        DefaultChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "very very long string",
            type: .random()
        ),
        DefaultChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "very long string",
            type: .random()
        ),
    ]
}

#Preview {
    DefaultChip_SUI(
        DefaultChip_SUI.DataModel.test[0],
        size: .M
    )

    DefaultChip_SUI(
        DefaultChip_SUI.DataModel.test[0],
        size: .S
    )

    DefaultChip_SUI(
        DefaultChip_SUI.DataModel.test[0],
        size: .XS
    )
    Spacer()
}
