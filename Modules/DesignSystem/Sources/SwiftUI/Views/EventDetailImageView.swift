//
//  EventDetailImageView.swift
//  DesignSystem
//
//  Created by Vladislav on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Platform
import Nuke
import NukeUI
import R
import SwiftUI

public struct EventDetailImageView: View {
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
                        StatusChip_SUI(data.status ?? .completed, size: .M)
                        Spacer()
                        VStack(alignment: .leading) {
                            nameView
                            chipsView
                        }
                    }
                    .padding(16)
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
            } else {
                RAsset.Placeholders.trainingDetail.swiftUIImage
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

public extension EventDetailImageView {
    struct DataModel {
        let imageURL: URL?
        let name: String
        let status: EventDetail.EventStatus?
        let chips: [CoverChip_SUI.DataModel]

        public init(imageURL: URL?, name: String, status: EventDetail.EventStatus?, chips: [CoverChip_SUI.DataModel]) {
            self.imageURL = imageURL
            self.name = name
            self.status = status
            self.chips = chips
        }

        static let test = DataModel(
            imageURL: URL(string: ""),
            name: "Финты",
            status: .completed,
            chips: CoverChip_SUI.DataModel.test
        )
    }
}
