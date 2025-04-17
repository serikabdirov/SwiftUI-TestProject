//
//  CharacteristicsView.swift
//  Exercise
//
//  Created by Серик Абдиров on 19.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct CharacteristicsView: View {
    let viewModel: ViewModel

    @State
    private var isExpanded = false
    @State
    private var textWidth: CGFloat = 0
    @State
    private var containerWidth: CGFloat = 0

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    viewModel.icon
                    Text(viewModel.name)
                        .font(UIFont.body2Med.swiftUIFont)
                        .foregroundStyle(UIColor.Text.secondary.swiftUIColor)
                    Spacer()
                    if textWidth >= containerWidth - 24 {
                        isExpanded ?
                            RAsset.Icons24.chevronUp.swiftUIImage
                            .foregroundStyle(UIColor.Icons.default.swiftUIColor) :
                            RAsset.Icons24.chevronDown.swiftUIImage
                            .foregroundStyle(UIColor.Icons.default.swiftUIColor)
                    }
                }
            }

            Text(viewModel.value)
                .font(UIFont.body2Reg.swiftUIFont)
                .lineLimit(isExpanded ? nil : 1)
                .lineSpacing(5)
                .foregroundStyle(UIColor.Text.main.swiftUIColor)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                textWidth = geo.size.width
                            }
                    }
                )
                .padding(.horizontal, DS.Gap.S)
                .padding(.vertical, DS.Gap.S)
                .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                containerWidth = geo.size.width
                            }
                    }
                )
                .background(UIColor.Background.grey.swiftUIColor)
                .clipShape(.rect(cornerRadius: DesignSystem.Corner.S))
        }
        .whiteRoundedBackgroundView()
    }
}

public extension CharacteristicsView {
    struct ViewModel: Identifiable, Equatable {
        public var id: String { name }

        let icon: Image?
        let name: String
        public let value: String

        public init(icon: Image?, name: String, value: String) {
            self.icon = icon
            self.name = name
            self.value = value
        }
    }
}
