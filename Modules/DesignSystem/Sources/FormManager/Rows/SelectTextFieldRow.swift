//
//  SelectTextFieldRow.swift
//  DesignSystem
//
//  Created by Zart Arn on 17.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import R

public final class SelectTextFieldRow: BaseTextFieldRow<String>, FormStackRow {
    
    public var isHiddenRightView: Bool = false {
        didSet {
            cell.textField.rightView?.isHidden = isHiddenRightView
        }
    }
    
    // MARK: - init

    public required init() {
        super.init()

        cell.textField.isUserInteractionEnabled = false
        cell.contentView.isUserInteractionEnabled = false
        // TODO: set chevronRight.image
        cell.textField.normalRightViewImage = RAsset.Icons24.chevronDown.image
        cell.textField.rightViewMode = .always
    }

    override func updateValue() {
        super.updateValue()
        cell.textField.text = value
    }

    public override func canBeFirstResponder() -> Bool {
        false
    }

    public override func isFirstResponder() -> Bool {
        false
    }
}
