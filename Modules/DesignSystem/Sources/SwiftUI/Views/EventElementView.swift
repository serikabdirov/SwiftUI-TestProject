//
//  EventElementView.swift
//  DesignSystem
//
//  Created by Vladislav on 24.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Nuke
import NukeUI
import Platform
import R
import SwiftUI

public struct EventElementView: View {
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
                    nameView
                }
                
                Spacer()
                RAsset.Icons24.chevronRight.swiftUIImage
            }
            Spacer(minLength: 12)
            chipsView
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
            } else {
                RAsset.Placeholders.placeholderSmall.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
    
    var chipsView: some View {
        FlexView(data.chips) { chipData in
            DefaultChip_SUI(chipData, size: .S)
        }
    }
}

public extension EventElementView {
    struct DataModel: Identifiable, Hashable {
        public let id: Int
        let imageUrl: URL?
        let name: String
        public var status: EventStatus
        let chips: [DefaultChip_SUI.DataModel]
        
        public init(
            id: Int,
            imageUrl: URL?,
            name: String,
            status: EventStatus,
            chips: [DefaultChip_SUI.DataModel]
        ) {
            self.id = id
            self.imageUrl = imageUrl
            self.name = name
            self.status = status
            self.chips = chips
        }
    }
}
