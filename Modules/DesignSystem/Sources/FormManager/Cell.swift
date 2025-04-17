//
//  Cell.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 09.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import UIKit

open class Cell: UIControl {
    public var contentView: UIView!
    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            updateLayout()
        }
    }

    // MARK: - init

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView = {
            let i = UIView()
            return i
        }()

        addSubview(contentView)
    }

    private func setupConstraints() {
        contentView.snp.makeConstraints {
            $0.top.equalTo(contentInsets.top)
            $0.leading.equalTo(contentInsets.left)
            $0.trailing.equalTo(-contentInsets.right)
            $0.bottom.equalTo(-contentInsets.bottom)
        }
    }

    private func updateLayout() {
        contentView.snp.remakeConstraints {
            $0.top.equalTo(contentInsets.top)
            $0.leading.equalTo(contentInsets.left)
            $0.trailing.equalTo(-contentInsets.right)
            $0.bottom.equalTo(-contentInsets.bottom)
        }
        
        contentView.setNeedsUpdateConstraints()
        contentView.updateConstraintsIfNeeded()
    }
}
