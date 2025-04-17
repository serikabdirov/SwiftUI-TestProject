//
//  CoverChip_SUI.swift
//  DesignSystem
//
//  Created by Александр Болотов on 05.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct CoverChip_SUI: View {
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
                .foregroundStyle(UIColor.Icons.white.swiftUIColor)
                .frame(width: size.iconSize, height: size.iconSize)
            Text(dataModel.title)
                .font(size.font)
                .foregroundStyle(dataModel.type.foregroundColor)
        }
        .padding(size.insets)
        .frame(height: size.height)
        .background(dataModel.type.backgroundColor.blur(radius: 0.8))
        .clipShape(.rect(cornerRadius: size.cornerRadius))
    }
}

public extension CoverChip_SUI {
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

public extension CoverChip_SUI {
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
                20
            case .S:
                16
            case .XS:
                12
            }
        }

        var insets: EdgeInsets {
            switch self {
            case .M:
                EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 10)
            case .S:
                EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 10)
            case .XS:
                EdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 10)
            }
        }
    }

    enum ChipType: CaseIterable {
        case cover
        case coverDone

        var foregroundColor: Color {
            switch self {
            case .cover:
                UIColor.Text.white.swiftUIColor
            case .coverDone:
                UIColor.Text.white.swiftUIColor
            }
        }

        var backgroundColor: Color {
            switch self {
            case .cover:
                UIColor.Background.darkChip.swiftUIColor
            case .coverDone:
                UIColor.Background.whiteChip.swiftUIColor
            }
        }

        static func random() -> Self {
            allCases.randomElement()!
        }
    }
}

public extension CoverChip_SUI.DataModel {
    static let test = [
        CoverChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "long string",
            type: .cover
        ),
        CoverChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "short",
            type: .cover
        ),
        CoverChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "very very long string",
            type: .cover
        ),
        CoverChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "long string",
            type: .coverDone
        ),
        CoverChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "short",
            type: .coverDone
        ),
        CoverChip_SUI.DataModel(
            icon: Image(systemName: "globe"),
            title: "very very long string",
            type: .coverDone
        ),
    ]
}

#Preview {
    CoverChip_SUI(
        CoverChip_SUI.DataModel.test[0],
        size: .M
    )

    CoverChip_SUI(
        CoverChip_SUI.DataModel.test[0],
        size: .S
    )

    CoverChip_SUI(
        CoverChip_SUI.DataModel.test[0],
        size: .XS
    )
    Spacer()
    CoverChip_SUI(
        CoverChip_SUI.DataModel.test[3],
        size: .M
    )

    CoverChip_SUI(
        CoverChip_SUI.DataModel.test[3],
        size: .S
    )

    CoverChip_SUI(
        CoverChip_SUI.DataModel.test[3],
        size: .XS
    )

    HStack(spacing: 0) {
        Color.red
        Color.green
        Color.blue
        Color.yellow
        Color.orange
        Color.black
        Color.indigo
    }.overlay {
        VStack {
            Text("FUCKFUCKFUICK")
                .padding()
                .background(
                    UIColor.Background.darkChip.swiftUIColor
                        .background(.ultraThinMaterial)
                )

            Text("AAAAAA-AA--AAAAA")
                .padding()
                .background(UIColor.Background.darkChip.swiftUIColor)
                .background(.ultraThinMaterial)

            Text("BLYAAA:LKJ:LKDJ:LFJK")
                .padding()
                .background(.ultraThinMaterial)

//            CustomBlurView(style: .systemUltraThinMaterial)
//                .frame(width: 200, height: 80)
//                .background(UIColor.Background.darkChip.swiftUIColor)

//            UIColor.Background.darkChip.swiftUIColor
//                .frame(width: 200, height: 80)
//                .background(CustomBlurView(style: .systemUltraThinMaterialDark))
//
//
//            Text("FUCKFUCKFUICK")
//                .padding()
//                .background(CustomBlurView(style: .systemUltraThinMaterialDark))

            Text("AAAAAA-AA--AAAAA")
                .padding()
                .background(UIColor.Background.darkChip.swiftUIColor)

//            UIColor(hex: "#3E3E3E").swiftUIColor
//                .frame(width: 200, height: 80)
//                .overlay(alignment: .center) {
//                    Text("FUCKFUCKFUICK")
//                        .padding()
//                        .background(CustomBlurView(style: .systemUltraThinMaterialLight))
//                }
//
        }
    }
}
