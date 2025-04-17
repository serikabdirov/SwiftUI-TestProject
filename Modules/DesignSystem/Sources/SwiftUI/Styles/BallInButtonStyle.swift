//
//  BallInButtonStyle.swift
//  Exercise
//
//  Created by Серик Абдиров on 19.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct BallInButtonStyle: ButtonStyle {
    let type: ButtonType
    let size: ButtonSize

    @Environment(\.isEnabled)
    var isEnabled: Bool

    init(_ type: ButtonType, size: ButtonSize) {
        self.type = type
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundStyle(UIColor.Text.white.swiftUIColor)
            .frame(height: size.height)
            .frame(maxWidth: .infinity, alignment: .center)

            .background(
                RoundedRectangle(cornerRadius: size.cornerRadius)
                    .fill(
                        !isEnabled ? type.disabledColor :
                            configuration.isPressed ? type.highlightedColor : type.normalColor
                    )
            )
    }
}

public extension BallInButtonStyle {
    enum ButtonType {
        case primary
        case secondary

        var normalColor: Color {
            switch self {
            case .primary:
                UIColor.Button.btnPrimary.swiftUIColor
            case .secondary:
                UIColor.Button.btnSecondary.swiftUIColor
            }
        }

        var highlightedColor: Color {
            switch self {
            case .primary:
                UIColor.Button.btnPrimaryTap.swiftUIColor
            case .secondary:
                UIColor.Button.btnSecondaryTap.swiftUIColor
            }
        }

        var disabledColor: Color {
            switch self {
            case .primary:
                UIColor.Button.btnDisabled.swiftUIColor
            case .secondary:
                UIColor.Button.btnDisabled.swiftUIColor
            }
        }
    }

    enum ButtonSize {
        case L
        case M
        case S
        case XS

        var height: CGFloat {
            switch self {
            case .L: 56
            case .M: 48
            case .S: 40
            case .XS: 36
            }
        }

        var font: Font {
            switch self {
            case .M,
                 .L: UIFont.btn1SemiBold.swiftUIFont
            case .S,
                 .XS: UIFont.btn3SemiBold.swiftUIFont
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .M,
                 .L: DesignSystem.Corner.M
            case .S,
                 .XS: DesignSystem.Corner.S
            }
        }
    }
}

public extension ButtonStyle where Self == BallInButtonStyle {
    static func ballInButton(_ type: BallInButtonStyle.ButtonType, size: BallInButtonStyle.ButtonSize = .M) -> Self {
        BallInButtonStyle(type, size: size)
    }
}
