//
//  SmartBottomPadding.swift
//  DesignSystem
//
//  Created by Евграфов Максим on 13.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct SmartBottomPadding: ViewModifier {
    var padding: CGFloat

    public func body(content: Content) -> some View {
        content
            .padding(.bottom, bottomPadding())
    }
    
    func bottomPadding() -> CGFloat {
        guard let window = UIWindow.keyWindow else {
            return padding
        }
        return (window.safeAreaInsets.bottom != 0) ? 0 : padding
    }
}

extension View {
    public func smartBottomPadding(_ padding: CGFloat) -> some View {
        self.modifier(SmartBottomPadding(padding: padding))
    }
}
