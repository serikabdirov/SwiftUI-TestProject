//
//  BaseButton.swift
//
//  Created by Марина Айбулатова on 08.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import SnapKit
import UIKit

public final class BaseButton: UIControl {
    // MARK: - Public properties

    public var text: String? {
        didSet { updateText() }
    }
    
    public var textAlignment: NSTextAlignment = .center {
        didSet { updateTextAppearance() }
    }

    public var contentInsets: UIEdgeInsets = .zero {
        didSet { updateContentInsets() }
    }

    public var height: CGFloat? {
        didSet { updateHeight() }
    }
    
    public var numberOfLines: Int = 1 {
        didSet { updateText() }
    }

    public var backgroundColors: [UIControl.State: UIColor] = [:] {
        didSet { updateBackgroundAppearance() }
    }

    public var borderColors: [UIControl.State: UIColor] = [:] {
        didSet { updateBorderAppearance() }
    }

    public var textColors: [UIControl.State: UIColor] = [:] {
        didSet { updateTextAppearance() }
    }
    
    public var imageColors: [UIControl.State: UIColor] = [:] {
        didSet {
            updateLeftImage()
            updateRightImage()
        }
    }

    public var cornerRadius: CGFloat = 0 {
        didSet { updateBorderAppearance() }
    }

    public var borderWidths: [UIControl.State: CGFloat] = [:] {
        didSet { updateBorderAppearance() }
    }

    public var font: UIFont = .systemFont(ofSize: 14) {
        didSet { updateTextAppearance() }
    }

    public var leftImage: UIImage? {
        didSet { updateLeftImage() }
    }

    public var rightImage: UIImage? {
        didSet { updateRightImage() }
    }

    // MARK: - Override properties

    override public var isEnabled: Bool {
        didSet { updateAppearance() }
    }

    override public var isHighlighted: Bool {
        didSet { updateAppearance() }
    }

    override public var isSelected: Bool {
        didSet { updateAppearance() }
    }

    // MARK: - Override methods

    override public func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        backgroundLayer.frame = bounds
        CATransaction.commit()
        textLabel.preferredMaxLayoutWidth = bounds.width - contentInsets.left - contentInsets.right
    }

    // MARK: - Private properties

    // swiftlint:disable implicitly_unwrapped_optional
    private let baseStackView = UIStackView()
    private let contentStackView = UIStackView()
    private var textLabel: UILabel!
    private var backgroundLayer: CALayer!

    private var contentLayoutGuide: UILayoutGuide!
    private var heightConstraint: Constraint!

    private var leftImageView: UIImageView!
    private var rightImageView: UIImageView!
    // swiftlint:enable implicitly_unwrapped_optional

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        configureViews()
        configureConstraints()
        updateAppearance()
        updateText()
    }

    // MARK: - Private methods

    private func configureViews() {
        textLabel = {
            let i = UILabel()
            i.numberOfLines = 0
            i.textAlignment = .center
            i.font = font
            return i
        }()

        leftImageView = {
            let imageView = UIImageView()
            imageView.isHidden = leftImage == nil
            imageView.contentMode = .center
            return imageView
        }()

        rightImageView = {
            let imageView = UIImageView()
            imageView.isHidden = rightImage == nil
            imageView.contentMode = .center
            return imageView
        }()

        backgroundLayer = {
            let i = CALayer()
            i.zPosition = -100
            return i
        }()
        
        contentStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        baseStackView.do {
            $0.isUserInteractionEnabled = false
            $0.axis = .vertical
        }

        layer.insertSublayer(backgroundLayer, at: 0)
        contentStackView.addArrangedSubview(leftImageView)
        contentStackView.addArrangedSubview(textLabel)
        contentStackView.addArrangedSubview(rightImageView)
        baseStackView.addArrangedSubview(contentStackView)
        addSubview(baseStackView)
    }

    private func configureConstraints() {
        contentLayoutGuide = UILayoutGuide()
        addLayoutGuide(contentLayoutGuide)
        updateContentInsets()
        
        baseStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentLayoutGuide)
        }
        
        leftImageView.snp.contentHuggingHorizontalPriority = 999
        leftImageView.snp.contentCompressionResistanceHorizontalPriority = 999
        rightImageView.snp.contentHuggingHorizontalPriority = 999
        rightImageView.snp.contentCompressionResistanceHorizontalPriority = 999

        snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(56).constraint
            heightConstraint.isActive = false
        }

        updateHeight()
    }

    // MARK: - Update methods

    private func updateContentInsets() {
        contentLayoutGuide.snp.updateConstraints { update in
            update.edges.equalTo(contentInsets)
        }
    }

    private func updateHeight() {
        if let height {
            heightConstraint.update(offset: height)
            heightConstraint.isActive = true
        } else {
            heightConstraint.isActive = false
        }
    }

    private func updateText() {
        textLabel.text = text
        textLabel.isHidden = textLabel.text.orEmpty.isEmpty
        textLabel.numberOfLines = numberOfLines
    }

    private func updateAppearance() {
        updateBackgroundAppearance()
        updateBorderAppearance()
        updateTextAppearance()
        updateLeftImage()
        updateRightImage()
    }

    private func updateBackgroundAppearance() {
        backgroundLayer.backgroundColor = backgroundColors.value(for: state)?.cgColor
    }

    private func updateTextAppearance() {
        textLabel.font = font
        textLabel.textColor = textColors.value(for: state)
        baseStackView.alignment = textAlignment.mapAlignment
    }

    private func updateBorderAppearance() {
        backgroundLayer.cornerRadius = cornerRadius
        backgroundLayer.borderColor = borderColors.value(for: state)?.cgColor
        backgroundLayer.borderWidth = borderWidths.value(for: state) ?? 0
    }

    private func updateLeftImage() {
        leftImageView.isHidden = leftImage == nil
        leftImageView.image = leftImage?.withTintColor(
            imageColors.value(for: state) ?? textColors.value(for: state) ?? .black,
            renderingMode: .alwaysOriginal
        )
    }

    private func updateRightImage() {
        rightImageView.isHidden = rightImage == nil
        rightImageView.image = rightImage?.withTintColor(
            imageColors.value(for: state) ?? textColors.value(for: state) ?? .black,
            renderingMode: .alwaysOriginal
        )
    }
}

extension NSTextAlignment {
    var mapAlignment: UIStackView.Alignment {
        switch self {
        case .left:
            .leading
        case .center:
            .center
        case .right:
            .trailing
        default:
            .center
        }
    }
}
