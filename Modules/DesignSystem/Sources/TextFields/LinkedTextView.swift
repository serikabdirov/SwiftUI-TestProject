//
//  LinkedTextView.swift
//  DesignSystem
//
//  Created by Vladislav on 16.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

public protocol LinkedTextViewDelegate: AnyObject {
    func didTapUrl(_ url: URL)
}

public final class LinkedTextView: UITextView, UITextViewDelegate {
    
    public weak var linkDelegate: LinkedTextViewDelegate?
    
    lazy var paragraphStyle = { NSMutableParagraphStyle().then {
        $0.alignment = textAlignment
        $0.lineSpacing = 4
    }}()
    
    lazy var textAttr: [NSAttributedString.Key: Any] = [
        .font: UIFont.body1Reg,
        .foregroundColor: UIColor.Text.main,
        .paragraphStyle: paragraphStyle
    ]
    
    lazy var linkAttr: [NSAttributedString.Key: Any] = [
        .font: UIFont.body1SemiBold,
        .foregroundColor: UIColor.Text.url
    ]
    
    // MARK: - Init
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Public methods
    
    public func setText(_ text: String, documents: [(String, URL)]) {
        let string = NSAttributedString(string: text, attributes: textAttr).mutable()

        for (linkText, url) in documents {
            guard let range = text.range(of: linkText) else { continue }
            let convertedRange = NSRange(range, in: text)
            string.addAttributes(linkAttr, range: convertedRange)
            string.addAttribute(.link, value: url, range: convertedRange)
        }

        self.attributedText = string
    }

    // MARK: - Private methods
    
    private func setupViews() {
        self.do {
            self.delegate = self
            $0.linkTextAttributes = [
                .foregroundColor: UIColor.Text.url,
            ]
            $0.textContainerInset = .zero
            $0.isEditable = false
            $0.isScrollEnabled = false
            $0.textAlignment = .left
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
    }

    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        linkDelegate?.didTapUrl(URL)
        return false
    }
}
