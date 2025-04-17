//
//  TitleComponent.swift
//
//  Created by Денис Кожухарь on 29.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import CarbonKit
import UIKit

public struct LabelComponent: IdentifiableComponent, Equatable {
    public var id: some Hashable { attributedText }

    let attributedText: NSAttributedString
    let textAlignment: NSTextAlignment
    let numberOfLines: Int
    let backgroundColor: UIColor
    let textInsets: UIEdgeInsets

    public init(
        text: String,
        font: UIFont,
        color: UIColor,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        backgroundColor: UIColor = .clear,
        textInsets: UIEdgeInsets = .zero
    ) {
        self.attributedText = NSAttributedString(string: text, attributes: [
            .font: font,
            .foregroundColor: color
        ])
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.backgroundColor = backgroundColor
        self.textInsets = textInsets
    }

    public init(
        attributedText: NSAttributedString,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        backgroundColor: UIColor = .clear,
        textInsets: UIEdgeInsets = .zero
    ) {
        self.attributedText = attributedText
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.backgroundColor = backgroundColor
        self.textInsets = textInsets
    }

    public func renderContent() -> InsetLabel {
        InsetLabel()
    }

    public func render(in content: InsetLabel) {
        content.attributedText = attributedText
        content.textAlignment = textAlignment
        content.numberOfLines = numberOfLines
        content.backgroundColor = backgroundColor
        content.textInsets = textInsets
    }
}
