//
//  StatusChip_SUI.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 06.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public protocol StatusChipDataModelProtocol {
    var title: String { get }
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}

public struct StatusChip_SUI: View {
    private let status: any StatusChipDataModelProtocol
    private let size: Size

    public init(_ status: any StatusChipDataModelProtocol, size: Size = .S) {
        self.status = status
        self.size = size
    }

    public var body: some View {
        Text(status.title)
            .font(size.font)
            .foregroundStyle(status.foregroundColor)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(status.backgroundColor)
            .clipShape(.rect(cornerRadius: size.cornerRadius))
    }
}

public extension StatusChip_SUI {
    enum Size {
        case M
        case S

        var height: CGFloat {
            switch self {
            case .M: 28
            case .S: 24
            }
        }

        var font: Font {
            switch self {
            case .M: UIFont.body2Med.swiftUIFont
            case .S: UIFont.captionMed.swiftUIFont
            }
        }

        var cornerRadius: CGFloat { DesignSystem.Corner.XL }
    }
}
