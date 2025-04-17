//
//  TrainingElementView.swift
//  Exercise
//
//  Created by Серик Абдиров on 03.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Nuke
import NukeUI
import Platform
import R
import SwiftUI

public struct TrainingElementView: View {
    let data: DataModel

    public init(_ data: DataModel) {
        self.data = data
    }

    public var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                imageView
                VStack(alignment: .leading) {
                    statusView

                    VStack(alignment: .leading) {
                        nameView
                        levelView
                    }
                }

                Spacer()
                RAsset.Icons24.chevronRight.swiftUIImage
            }
            Spacer(minLength: 12)
            chipsView

            if data.progress != 0.0 || data.status == .inProgress {
                Spacer(minLength: 16)
                progressView
            }
        }

        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.horizontal], 12)
        .padding([.vertical], 16)
        .background(UIColor.Main.white.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
    }

    var imageView: some View {
        LazyImage(url: data.imageUrl) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
        .overlay {
            if data.status == .completed {
                ZStack {
                    UIColor.Green._92.withAlphaComponent(0.4).swiftUIColor
                    RAsset.Icons24.doneWhite.swiftUIImage
                        .resizable()
                        .scaledToFill()
                        .padding(8)
                }
            }
        }
        .frame(width: 74, height: 74)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    var statusView: some View {
        StatusChip_SUI(data.status)
    }

    var nameView: some View {
        Text(data.name)
            .font(UIFont.body1SemiBold.swiftUIFont)
            .foregroundStyle(UIColor.Text.main.swiftUIColor)
            .multilineTextAlignment(.leading)
    }

    var levelView: some View {
        Text(data.level)
            .font(UIFont.captionMed.swiftUIFont)
            .foregroundStyle(UIColor.Text.tertiary.swiftUIColor)
            .multilineTextAlignment(.leading)
    }

    var progressView: some View {
        HStack {
            ProgressView(value: data.progress)
                .frame(height: 8)
                .tint(UIColor.Background.activityProgressBar.swiftUIColor)

            Text(data.progress.formatted(.percent.precision(.fractionLength(0))))
                .font(UIFont.captionMed.swiftUIFont)
                .foregroundStyle(UIColor.Main.black.swiftUIColor)
        }
    }

    var chipsView: some View {
        FlexView(data.chips) { chipData in
            DefaultChip_SUI(chipData, size: .S)
        }
    }
}

public extension TrainingElementView {
    struct DataModel: Identifiable, Hashable {
        public let id: Int
        let imageUrl: URL?
        let name: String
        let level: String
        let status: Status
        let chips: [DefaultChip_SUI.DataModel]
        let progress: Double
        let imagePlaceholder: Image
        let imageError: Image
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        public init(
            id: Int,
            imageUrl: URL?,
            name: String,
            level: String,
            status: Status,
            chips: [DefaultChip_SUI.DataModel],
            progress: Double,
            imagePlaceholder: Image,
            imageError: Image
        ) {
            self.id = id
            self.imageUrl = imageUrl
            self.name = name
            self.level = level
            self.status = status
            self.chips = chips
            self.progress = progress
            self.imagePlaceholder = imagePlaceholder
            self.imageError = imageError
        }
    }
}

struct TrainingElementView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingElementView(TrainingElementView.DataModel.test[0])
            .previewLayout(.sizeThatFits)
    }
}

extension TrainingElementView.DataModel {
    static let test = (100 ..< 105).map { id in
        Self(
            id: id,
            imageUrl: URL(string: "https://http.cat/\(id)"),
            name: "NAME NAME NAME NAME NAME NAME NAME NAME NAME NAME NAME NAME NAME NAME \(id)",
            level: "Start level",
            status: Status.allCases.randomElement()!,
            chips: DefaultChip_SUI.DataModel.test,
            progress: [0.10, 0.5, 0.9, 1.0].randomElement()!,
            imagePlaceholder: RAsset.Placeholders.trainingList.swiftUIImage,
            imageError: RAsset.ErrorImage.trainingList.swiftUIImage
        )
    }

    static let test2 = (200 ..< 205).map { id in
        Self(
            id: id,
            imageUrl: URL(string: "https://http.cat/\(id)"),
            name: "NAME \(id)",
            level: "Start level",
            status: Status.allCases.randomElement()!,
            chips: DefaultChip_SUI.DataModel.test,
            progress: [0.10, 0.5, 0.9, 1.0].randomElement()!,
            imagePlaceholder: RAsset.Placeholders.trainingList.swiftUIImage,
            imageError: RAsset.ErrorImage.trainingList.swiftUIImage
        )
    }
}
