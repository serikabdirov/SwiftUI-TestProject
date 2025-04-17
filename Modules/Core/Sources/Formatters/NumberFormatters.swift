//
//  NumberFormatters.swift
//  Core
//
//  Created by Денис Кожухарь on 13.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public extension NumberFormatter {

    static var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter
    }()
}
