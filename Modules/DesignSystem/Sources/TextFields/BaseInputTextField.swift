//
//  BaseInputTextField.swift
//  DesignSystem
//
//  Created by Vladislav on 20.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import UIKit

public class BaseInputTextField: FloatingPlaceholderTextField {
    public init() {
        super.init(frame: .zero)
                
        textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        floatingPlaceholderInsets = UIEdgeInsets(top: 6.5, left: 16, bottom: 0, right: 0)
        textFont = .body1Reg
        placeholderFont = .body1Reg
        floatingPlaceholderFont = .captionReg
        
        normalTextColor = .Text.main
        
        placeholderColor = .Text.secondary
        borderWidth = 1
        borderCornerRadius = DesignSystem.Corner.M

        normalBorderColor = .Stroke.default
        focusedBorderColor = .Stroke.activeGreen
        errorBorderColor = .Error.stroke
        disabledBorderColor = .Grey._90
        
        borderHeight = 52
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
