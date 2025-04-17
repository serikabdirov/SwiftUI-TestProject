//
//  HashtagView.swift
//  DesignSystem
//
//  Created by Александр Болотов on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//


import R
import SwiftUI

public struct HashtagView: View {
    let description: String

    public init(_ description: String) {
        self.description = description
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(RStrings.Ls.Events.Detail.hashtag)
                .font(UIFont.body2Med.swiftUIFont)
                .foregroundStyle(UIColor.Text.secondary.swiftUIColor)

            Text(description)
                .font(UIFont.body1Reg.swiftUIFont)
                .foregroundStyle(UIColor.Text.main.swiftUIColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(UIColor.Main.white.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
    }
}
