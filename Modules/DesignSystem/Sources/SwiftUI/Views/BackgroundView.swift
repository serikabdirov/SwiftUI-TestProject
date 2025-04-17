//
//  BackgroundView.swift
//  Exercise
//
//  Created by Серик Абдиров on 19.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct BackgroundView<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 8) {
            content
        }
        .padding(8)
        .background(UIColor.Background.grey.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.L))
    }
}

public struct BackgroundViewModifier: ViewModifier {
    let alignment: Alignment
    
    public init(alignment: Alignment) {
        self.alignment = alignment
    }

    public func body(content: Content) -> some View {
        BackgroundView {
            content
                .frame(maxWidth: .infinity, alignment: alignment)
                .padding(DS.Gap.M)
                .background(UIColor.Main.white.swiftUIColor)
                .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
        }
    }
}

public struct WhiteRoundedBackgroundViewModifier: ViewModifier {
    let alignment: Alignment
    
    public init(alignment: Alignment) {
        self.alignment = alignment
    }

    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: alignment)
            .padding(DS.Gap.M)
            .background(UIColor.Main.white.swiftUIColor)
            .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
    }
}

public extension View {
    func withBackgroundView(alignment: Alignment = .leading) -> some View {
        modifier(BackgroundViewModifier(alignment: alignment))
    }

    func whiteRoundedBackgroundView(alignment: Alignment = .leading) -> some View {
        modifier(WhiteRoundedBackgroundViewModifier(alignment: alignment))
    }
}
