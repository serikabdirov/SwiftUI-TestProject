//
//  SpacerComponent.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 16.12.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import CarbonKit
import UIKit

public final class IntrinsicSizeView: UIView {
    var size: CGSize = .zero {
        didSet {
            if size != oldValue {
                invalidateIntrinsicContentSize()
            }
        }
    }

    override public var intrinsicContentSize: CGSize {
        size
    }
}

public struct SpacerComponent: IdentifiableComponent, Equatable {
    public var id: CGSize { size }

    let size: CGSize
    let color: UIColor

    public init(width: CGFloat, color: UIColor = .clear) {
        self.init(size: CGSize(width: width, height: UIView.noIntrinsicMetric), color: color)
    }

    public init(height: CGFloat, color: UIColor = .clear) {
        self.init(size: CGSize(width: UIView.noIntrinsicMetric, height: height), color: color)
    }

    public init(size: CGSize, color: UIColor = .clear) {
        self.size = size
        self.color = color
    }

    public func renderContent() -> IntrinsicSizeView {
        IntrinsicSizeView()
    }

    public func render(in content: IntrinsicSizeView) {
        content.size = size
        content.backgroundColor = color
    }
}

extension CGSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}
