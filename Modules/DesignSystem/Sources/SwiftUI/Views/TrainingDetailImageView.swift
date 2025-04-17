//
//  TrainingDetailImageView.swift
//  Exercise
//
//  Created by Серик Абдиров on 06.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Nuke
import NukeUI
import Platform
import R
import SwiftUI

public struct TrainingDetailImageView: View {
    let data: DataModel

    public init(data: DataModel) {
        self.data = data
    }

    public var body: some View {
        image
            .frame(height: 258)
            .overlay {
                ZStack {
                    LinearGradient(
                        colors: [
                            UIColor(hex: "#181818", alpha: 0.0).swiftUIColor,
                            UIColor(hex: "#000000", alpha: 0.72).swiftUIColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    VStack(alignment: .leading) {
                        FlowHStack(horizontalSpacing: DS.Gap.S, verticalSpacing: DS.Gap.S) {
                            ForEach(data.statusChips, id: \.title) { chip in
                                StatusChip_SUI(chip, size: .M)
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            nameView
                            chipsView
                        }
                    }
                    .padding(DS.Gap.L)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Corner.L))
    }

    var image: some View {
        LazyImage(url: data.imageURL) { state in
            if let image = state.image {
                GeometryReader { geometry in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                }
            } else if let _ = state.error {
                data.imageError
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                data.imagePlaceholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }

    var nameView: some View {
        Text(data.name)
            .font(UIFont.h2Bold.swiftUIFont)
            .foregroundStyle(UIColor.Text.white.swiftUIColor)
    }

    var chipsView: some View {
        FlexView(data.chips) { chip in
            CoverChip_SUI(chip, size: .M)
        }
    }
}

public extension TrainingDetailImageView {
    struct DataModel {
        let imageURL: URL?
        let name: String
        let statusChips: [any StatusChipDataModelProtocol]
        let chips: [CoverChip_SUI.DataModel]
        let imagePlaceholder: Image
        let imageError: Image

        public init(
            imageURL: URL?,
            name: String,
            statusChips: [any StatusChipDataModelProtocol],
            chips: [CoverChip_SUI.DataModel],
            imagePlaceholder: Image,
            imageError: Image
        ) {
            self.imageURL = imageURL
            self.name = name
            self.statusChips = statusChips
            self.chips = chips
            self.imagePlaceholder = imagePlaceholder
            self.imageError = imageError
        }

        static let test = DataModel(
            imageURL: URL(string: ""),
            name: "Финты",
            statusChips: [Status.completed],
            chips: CoverChip_SUI.DataModel.test,
            imagePlaceholder: RAsset.Placeholders.trainingDetail.swiftUIImage,
            imageError: RAsset.ErrorImage.trainingDetail.swiftUIImage
        )
    }
}

#Preview {
    TrainingDetailImageView(data: .test)
}
