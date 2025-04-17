//
//  NotificationToastView.swift
//  Running
//
//  Created by Александр Болотов on 17.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import UIKit

public final class NotificationToastView: UIView {
    // MARK: - Public properties

    public var title: String? {
        didSet {
            label.text = title
        }
    }

    // MARK: - Private properties

    private let label = UILabel()

    // MARK: - Init

    public init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        self.title = nil
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViews() {
        layer.borderColor = UIColor.Stroke.activeGreen.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = DS.Corner.S
        backgroundColor = .Background.greenCard2

        label.do { i in
            i.text = title
            i.font = .body2Med
            i.textColor = .Text.main
        }

        addSubview(label)
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(18)
            make.horizontalEdges.equalToSuperview().inset(DS.Gap.L)
        }
    }
}
