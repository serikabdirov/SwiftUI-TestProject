//
//  EventDescriptionView.swift
//  DesignSystem
//
//  Created by Vladislav on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//
import SwiftUI
import Platform
import NukeUI

public struct EventListView: View {
    let viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.title)
                    .font(UIFont.body2Med.swiftUIFont)
                    .foregroundStyle(UIColor.Text.secondary.swiftUIColor)
            }
            
            if let _ = viewModel.examplePhoto {
                image
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Corner.S))
            } else {
                Text(viewModel.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(UIFont.body2Reg.swiftUIFont)
                    .foregroundStyle(UIColor.Text.main.swiftUIColor)
                    .padding(.vertical, 8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(UIColor.Main.white.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
    }
    
    var image: some View {
        LazyImage(url: viewModel.examplePhoto) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                RAsset.Placeholders.trainingDetail.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}

public extension EventListView {
    struct ViewModel: Identifiable, Equatable {
        public var id: String { title }

        public let examplePhoto: URL?
        let title: String
        public let description: String

        public init(examplePhoto: URL?, title: String, description: String) {
            self.examplePhoto = examplePhoto
            self.title = title
            self.description = description
        }
    }
}
