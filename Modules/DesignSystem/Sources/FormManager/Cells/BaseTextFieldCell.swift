//
//  BaseTextFieldCell.swift
//
//  Created by Alexey Ostroverkhov on 09.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import UIKit

open class BaseTextFieldCell: Cell {
    public var textField = DesignSystem.TextFields.floatingTextField()

    // MARK: - init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }

    // MARK: - setup

    private func setupViews() {
        contentView.addSubview(textField)
    }

    private func setupConstraints() {
        let zero: Int = .zero
        textField.snp.makeConstraints {
            $0.top.equalTo(zero)
            $0.leading.equalTo(zero)
            $0.trailing.equalTo(zero)
            $0.bottom.equalTo(zero)
        }
    }

    // MARK: - Public Method
}

