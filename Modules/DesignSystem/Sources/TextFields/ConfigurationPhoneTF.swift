//
//  TextField.swift
//  DesignSystem
//
//  Created by Vladislav on 17.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

public class ConfigurationPhoneTF: BorderTextField {
    public init() {
        super.init(frame: .zero)
        font = .body1Reg
        textColor = .Text.main
        tintColor = .Text.main

        hintFont = .helperReg
        hintInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        errorColor = .Error.text

        placeholderColor = .Text.secondary

        borderColor = .Stroke.default
        focusedBorderColor = .Stroke.activeGreen
        errorBorderColor = .Error.stroke
        disabledBorderColor = .Grey._90

        disabledContentBackgroundColor = .Button.btnDisabled
        borderHeight = 52
        sideViewInset = 16
        sideViewTextInset = 8
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
