//
//  DescriptionView.swift
//  Exercise
//
//  Created by Серик Абдиров on 19.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import R
import SwiftUI

public struct DescriptionView: View {
    let viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public init(_ description: String, title: String) {
        self.viewModel = .init(description, title: title)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DS.Gap.S) {
            Text(viewModel.descriptionTitle)
                .font(UIFont.body2Med.swiftUIFont)
                .foregroundStyle(UIColor.Text.secondary.swiftUIColor)

            Text(viewModel.description)
                .font(UIFont.body1Reg.swiftUIFont)
                .foregroundStyle(UIColor.Text.main.swiftUIColor)
        }
        .whiteRoundedBackgroundView()
    }
}

public extension DescriptionView {
    struct ViewModel: Identifiable, Equatable {
        public var id: String { descriptionTitle }

        let descriptionTitle: String
        let description: String
        
        public init(_ description: String, title: String) {
            self.description = description
            self.descriptionTitle = title
        }
    }
}
