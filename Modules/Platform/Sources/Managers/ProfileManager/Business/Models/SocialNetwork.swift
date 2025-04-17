//
//  SocialNetwork.swift
//  Platform
//
//  Created by Дмитрий Костиков on 10.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public enum SocialNetworkType: String, Codable, CaseIterable {
    case vk
    case telegram
    case tiktok
    case youtube
    case instagram
    case facebook
}

public struct SocialNetwork: Codable {
    public let type: SocialNetworkType
    public let url: String?
    
    public init(type: SocialNetworkType, url: String?) {
        self.type = type
        self.url = url
    }
}
