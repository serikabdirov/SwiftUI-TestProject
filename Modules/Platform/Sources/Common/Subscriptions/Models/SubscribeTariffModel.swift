//
//  SubscribeTariffModel.swift
//  Subscribe
//
//  Created by Евграфов Максим on 26.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import R

public struct SubscribeTariffModel: Decodable, Hashable {
    public let id: Int
    public let name: String
    public let cover: URL?
    public let duration: Int
    public let price: Int
    public let appleProductId: String?
    
    public func getPriceFormatted(price: Int) -> String {
        "\(FormatHelpers.formatPrice(Decimal(price), code: "RUB", fractionLength: 0))"
    }
    
    public func getDuration(for mounthCount: Int) -> String {
        if mounthCount == 12 {
            RStrings.Ls.Subscription.Main.Period.year
        } else if mounthCount == 1 {
            RStrings.Ls.Subscription.Main.Period.month
        } else {
            ""
        }
    }
    
    public init(id: Int, name: String, cover: URL?, duration: Int, price: Int, appleProductId: String?) {
        self.id = id
        self.name = name
        self.cover = cover
        self.duration = duration
        self.price = price
        self.appleProductId = appleProductId
    }
}


