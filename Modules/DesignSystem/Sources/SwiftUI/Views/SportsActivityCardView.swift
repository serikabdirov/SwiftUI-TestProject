//
//  TrainingDetailExerciseView.swift
//  Exercise
//
//  Created by Серик Абдиров on 10.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Nuke
import NukeUI
import R
import SwiftUI

public struct SportsActivityCardView: View {
    private let data: DataModel
    private let state: State

    public init(_ data: DataModel, state: State) {
        self.data = data
        self.state = state
    }

    public var body: some View {
        HStack(spacing: 8) {
            image
            HStack(spacing: 8) {
                content
                Spacer()
                RAsset.Icons24.chevronRight.swiftUIImage
                    .renderingMode(.template)
                    .foregroundStyle(state.titleTextColor)
            }
            .padding(.horizontal, 12)
            .background(state.backgroundColor.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Corner.S)))
        }
        .frame(height: 56)
    }

    var image: some View {
        LazyImage(url: data.imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                RAsset.Placeholders.exercise.swiftUIImage
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: 56, height: 56)
        .overlay {
            if state == .done {
                ZStack {
                    UIColor.Green._92.withAlphaComponent(0.4).swiftUIColor
                    RAsset.Icons24.doneWhite.swiftUIImage
                        .resizable()
                        .scaledToFill()
                        .padding(8)
                }
            } else if state == .disabled {
                UIColor(hex: "#F0F0F0").withAlphaComponent(0.6).swiftUIColor
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 4) {
            Spacer()
            Text(data.title)
                .font(UIFont.body2SemiBold.swiftUIFont)
                .foregroundStyle(state.titleTextColor)
            Text(data.description)
                .font(UIFont.captionMed.swiftUIFont)
                .foregroundStyle(state.descriptionTextColor)
            Spacer()
        }
    }
}

struct TrainingDetailExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        SportsActivityCardView(.test, state: .disabled)
            .previewLayout(.sizeThatFits)
    }
}

public extension SportsActivityCardView {
    struct DataModel: Identifiable {
        public var id: Int
        var title: String
        var description: String
        var imageURL: URL?

        static let test = Self(
            id: 1,
            title: "title",
            description: "description",
            imageURL: URL(string: "https://http.cat/100")
        )

        public init(id: Int, title: String, description: String, imageURL: URL? = nil) {
            self.id = id
            self.title = title
            self.description = description
            self.imageURL = imageURL
        }
    }
}

public extension SportsActivityCardView {
    enum State {
        case ready
        case done
        case disabled
        case `default`

        var backgroundColor: Color {
            switch self {
            case .ready:
                UIColor.Background.yellowActivityCard.swiftUIColor
            case .done:
                UIColor.Background.grey2.swiftUIColor
            case .disabled:
                UIColor.Background.white.swiftUIColor
            case .default:
                UIColor.Background.grey.swiftUIColor
            }
        }

        var titleTextColor: Color {
            switch self {
            case .disabled:
                UIColor.Text.disabled.swiftUIColor
            default:
                UIColor.Text.main.swiftUIColor
            }
        }

        var descriptionTextColor: Color {
            switch self {
            case .disabled:
                UIColor.Text.disabled.swiftUIColor
            default:
                UIColor.Text.tertiary.swiftUIColor
            }
        }
    }
}
