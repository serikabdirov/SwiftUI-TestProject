//
//  SubscribeBenefitModel.swift
//  Subscribe
//
//  Created by Евграфов Максим on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public struct SubscribeBenefitModel: Decodable, Hashable {
    public let title: String
    public let desc: String
    public let icon: URL?
    
    public enum CodingKeys: String, CodingKey {
        case title
        case desc = "description"
        case icon
    }
    
    public init(title: String, desc: String, icon: URL?) {
        self.title = title
        self.desc = desc
        self.icon = icon
    }
}
