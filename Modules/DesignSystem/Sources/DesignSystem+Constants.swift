//
//  DesignSystem+Constants.swift
//
//  Created by Денис Кожухарь on 11.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public extension DesignSystem {
    enum Constants {}
    enum Corner {}
    enum Gap {}
}

// MARK: - DesignSystem.Constants

public extension DesignSystem.Constants {
    static let mainPadding: CGFloat = 16
    static let mainInsets = UIEdgeInsets(top: 0, left: mainPadding, bottom: 0, right: mainPadding)
    static let smartBottomPadding: CGFloat = 8
    static let mainDirectionalInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: mainPadding,
        bottom: 0,
        trailing: mainPadding
    )
}

// MARK: - DesignSystem.Corner

public extension DesignSystem.Corner {
    /// 6
    static let XXS: CGFloat = 6
    /// 8
    static let XS: CGFloat = 8
    /// 12
    static let S: CGFloat = 12
    /// 16
    static let M: CGFloat = 16
    /// 20
    static let L: CGFloat = 20
    /// 24
    static let XL: CGFloat = 24
}

// MARK: - DesignSystem.Gap

public extension DesignSystem.Gap {
    /// 4
    static let XS: CGFloat = 4
    /// 8
    static let S: CGFloat = 8
    /// 12
    static let M: CGFloat = 12
    /// 16
    static let L: CGFloat = 16
    /// 24
    static let XL: CGFloat = 24
    /// 40
    static let XXL: CGFloat = 40
}
