//
//  ImageComponent.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 30.03.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import CarbonKit
import UIKit

public struct ImageComponent: Component, Equatable {
    public let image: UIImage
    public let cornerRadius: CGFloat
    public let contentMode: UIView.ContentMode

    public init(image: UIImage, cornerRadius: CGFloat = 0, contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.image = image
        self.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }

    public func renderContent() -> UIImageView {
        UIImageView()
    }

    public func render(in content: UIImageView) {
        content.image = image
        content.layer.cornerRadius = cornerRadius
        content.clipsToBounds = cornerRadius > 0
        content.contentMode = contentMode
    }
}
