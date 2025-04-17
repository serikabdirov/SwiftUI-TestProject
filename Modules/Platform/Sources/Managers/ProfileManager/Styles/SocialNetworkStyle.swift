//
//  Untitled.swift
//  Platform
//
//  Created by Zart Arn on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import SwiftUI
import R

public extension SocialNetworkType {
    
    var title: String {
        switch self {
        case .vk:
            "ВКонтакте"
        case .telegram:
            "Telegram"
        case .tiktok:
            "TikTok"
        case .youtube:
            "YouTube"
        case .instagram:
            "Instagram"
        case .facebook:
            "Facebook"
        }
    }
    
    var image: Image {
        switch self {
        case .vk: RAsset.SocialNetworkLogo.vkLogo.swiftUIImage
        case .telegram: RAsset.SocialNetworkLogo.tgLogo.swiftUIImage
        case .tiktok: RAsset.SocialNetworkLogo.tiktokLogo.swiftUIImage
        case .facebook: RAsset.SocialNetworkLogo.facebookLogo.swiftUIImage
        case .instagram: RAsset.SocialNetworkLogo.instagramLogo.swiftUIImage
        case .youtube: RAsset.SocialNetworkLogo.youtubeLogo.swiftUIImage
        }
    }
}
