//
//  FloatingPlaceholderTextField.swift
//  DesignSystem
//
//  Created by Vladislav on 09.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

// MARK: - Properties

public class FloatingPlaceholderTextField: UITextField {
    // MARK: - Background properties
    
    public var normalBackgroundColor: UIColor = .white {
        didSet { updateBackgroundAppearance() }
    }

    public var disabledBackgroundColor: UIColor = .white {
        didSet { updateBackgroundAppearance() }
    }

    // MARK: - Text properties

    public var textFont: UIFont = .systemFont(ofSize: 14) {
        didSet { updateTextAppearance() }
    }

    public var textInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) {
        didSet {
            if textInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }

    public var normalTextColor: UIColor = .black {
        didSet { updateTextAppearance() }
    }

    public var disabledTextColor: UIColor = .gray {
        didSet { updateTextAppearance() }
    }

    // MARK: - Border properties

    var borderHeight: CGFloat = 44 {
        didSet {
            if borderHeight != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }

    public var normalBorderColor: UIColor = .black {
        didSet { updateBorderAppearance() }
    }

    public var disabledBorderColor: UIColor = .black {
        didSet { updateBorderAppearance() }
    }

    public var focusedBorderColor: UIColor = .black {
        didSet { updateBorderAppearance() }
    }

    public var successBorderColor: UIColor = .green {
        didSet { updateBorderAppearance() }
    }

    public var errorBorderColor: UIColor = .red {
        didSet { updateBorderAppearance() }
    }

    public var borderWidth: CGFloat = .zero {
        didSet { updateBorderAppearance() }
    }

    public var borderCornerRadius: CGFloat = .zero {
        didSet { updateBorderAppearance() }
    }

    // MARK: - Placeholder properties

    public var placeholderColor: UIColor = .black {
        didSet { updatePlaceholderAppearance() }
    }

    public var disabledPlaceholderColor: UIColor = .gray {
        didSet { updatePlaceholderAppearance() }
    }

    public var placeholderFont: UIFont = .systemFont(ofSize: 14) {
        didSet { updatePlaceholderAppearance() }
    }

    public var floatingPlaceholderFont: UIFont = .systemFont(ofSize: 14) {
        didSet { updatePlaceholderAppearance() }
    }

    public var floatingPlaceholderInsets: UIEdgeInsets = .zero {
        didSet {
            if floatingPlaceholderInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }

    // MARK: - Hint properties

    public var normalHintColor: UIColor = .black {
        didSet { updateHintAppearance() }
    }
    
    public var normalRightTextLabelColor: UIColor = .black {
        didSet { updateHintAppearance() }
    }

    public var errorHintColor: UIColor = .red {
        didSet { updateHintAppearance() }
    }

    public var successHintColor: UIColor = .red {
        didSet { updateHintAppearance() }
    }

    public var hintFont: UIFont = .systemFont(ofSize: 6) {
        didSet { updateHintAppearance() }
    }
    
    public var rightViewLabelFont: UIFont = .systemFont(ofSize: 6) {
        didSet { updateRightViewLabelAppearance() }
    }

    public var hintInsets: UIEdgeInsets = .zero {
        didSet {
            if hintInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }

    // MARK: - Accessory properties

    /// Горизонтальный инсет для left и right view
    var sideViewsHorizontalInset: CGFloat = 8 {
        didSet {
            if sideViewsHorizontalInset != oldValue {
                setNeedsLayout()
                layoutIfNeeded()
            }
        }
    }
    
    var sideRightViewLabelHorizontalInset: CGFloat = 8 {
        didSet {
            if sideViewsHorizontalInset != oldValue {
                setNeedsLayout()
                layoutIfNeeded()
            }
        }
    }

    // MARK: - Accessory properties: Right view
    
    public var rightViewLabelText: String? {
        didSet { setRightTextLabel(rightViewLabelText ?? " ") }
    }

    public var rightViewInsets: UIEdgeInsets = .zero {
        didSet {
            if rightViewInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }

    public var rightViewText: String? {
        didSet { updateRightViewAppearance() }
    }

    public var rightViewFont: UIFont? = .systemFont(ofSize: 10) {
        didSet { updateRightViewAppearance() }
    }

    public var normalRightViewImage: UIImage? {
        didSet { updateRightViewAppearance() }
    }

    public var highlightedRightViewImage: UIImage? {
        didSet { updateRightViewAppearance() }
    }

    public var normalRightViewTintColor: UIColor = .black {
        didSet { updateRightViewAppearance() }
    }

    public var highlightedRightViewTintColor: UIColor = .red {
        didSet { updateRightViewAppearance() }
    }

    public var rightViewAction: (() -> Void)?

    // MARK: - Override properties

    override public var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width
        var hintHeight = hintHeight()
        if hintHeight > 0 {
            hintHeight += hintInsets.top + hintInsets.bottom
        }
        return CGSize(width: width, height: borderHeight + hintHeight)
    }

    override public var placeholder: String? {
        didSet { setPlaceholder(placeholder) }
    }

    override public var text: String? {
        didSet { setNeedsLayout() }
    }

    override public var isEnabled: Bool {
        didSet { updateAppearance() }
    }

    // MARK: - Private properties

    private var floatingPlaceholderLabel: UILabel!
    private var staticPlaceholderLabel: UILabel!
    private var hintLabel: UILabel!
    private var borderView: UIView!
    private var rightAccessoryButton: UIButton!
    private var leftAccessoryButton: UIButton!
    private var rightViewLabel: UILabel!

    private var isError = false
    private var isSuccess = false

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension FloatingPlaceholderTextField {
    private func configureViews() {
        floatingPlaceholderLabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textAlignment = .left
            label.isUserInteractionEnabled = false
            return label
        }()

        staticPlaceholderLabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textAlignment = .left
            label.isUserInteractionEnabled = false
            return label
        }()

        hintLabel = {
            let i = UILabel()
            i.numberOfLines = 1
            i.font = hintFont
            i.textColor = normalHintColor
            i.textAlignment = .left
            i.isUserInteractionEnabled = false
            return i
        }()
        
        rightViewLabel = {
            let i = UILabel()
            i.numberOfLines = 1
            i.font = rightViewLabelFont
            i.textColor = normalRightTextLabelColor
            i.textAlignment = .center
            i.isUserInteractionEnabled = false
            return i
        }()

        borderView = {
            let i = UIView()
            i.backgroundColor = .clear
            i.isUserInteractionEnabled = false
            return i
        }()

        leftAccessoryButton = UIButton()
        rightAccessoryButton = UIButton()

        contentVerticalAlignment = .top
        borderStyle = .none
        clearButtonMode = .never
        rightViewMode = .never

        addSubview(borderView)
        addSubview(floatingPlaceholderLabel)
        addSubview(staticPlaceholderLabel)
        addSubview(hintLabel)
        addSubview(rightViewLabel)

        addTarget(self, action: #selector(editingChanged), for: .allEditingEvents)

        updateAppearance()
    }

    // MARK: - Overrides
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)

        let floatingPlaceholderHeight = floatingPlaceholderInsets.top +
            placeholderFont.lineHeight +
            floatingPlaceholderInsets.bottom

        let leftViewPadding = (leftView?.superview == nil) ? textInsets.left : sideViewsHorizontalInset
        let rightViewPadding = (rightView?.superview == nil) ? textInsets.right : sideViewsHorizontalInset

        let rightViewLabelWidth = rightViewLabel.intrinsicContentSize.width

        let totalRightPadding = rightViewPadding + rightViewLabelWidth

        let textHeight = font?.lineHeight ?? 0

        let newBounds = CGRect(
            x: superRect.origin.x + leftViewPadding,
            y: floatingPlaceholderHeight + textInsets.top,
            width: superRect.width - leftViewPadding - totalRightPadding,
            height: textHeight
        )

        return newBounds
    }


//    ---То, что было раньше---
    
//    override public func textRect(forBounds bounds: CGRect) -> CGRect {
//        let superRect = super.textRect(forBounds: bounds)
//
//        let floatingPlaceholderHeight = floatingPlaceholderInsets.top +
//            placeholderFont.lineHeight +
//            floatingPlaceholderInsets.bottom
//
//        let leftViewPadding = (leftView?.superview == nil) ? textInsets.left : sideViewsHorizontalInset
//        let rightViewPadding = (rightView?.superview == nil) ? textInsets.right : sideViewsHorizontalInset
//
//        let textHeight = font?.lineHeight ?? 0
//
//
//        let newBounds = CGRect(
//            x: superRect.origin.x + leftViewPadding,
//            y: floatingPlaceholderHeight + textInsets.top,
//            width: superRect.width - leftViewPadding - rightViewPadding,
//            height: textHeight
//        )
//
//        return newBounds
//    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        .zero
    }

    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var superRect = super.leftViewRect(forBounds: bounds)
        let centerY = borderView.frame.midY
        superRect.origin.y = centerY - superRect.height / 2
        superRect.origin.x += sideViewsHorizontalInset
        return superRect
    }

    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var superRect = super.rightViewRect(forBounds: bounds)
        let centerY = borderView.frame.midY
        superRect.origin.y = centerY - superRect.height / 2
        superRect.origin.x -= sideViewsHorizontalInset

        let newRect = CGRect(
            x: superRect.origin.x - textInsets.right / 2,
            y: superRect.origin.y,
            width: superRect.width + textInsets.right,
            height: superRect.height
        )

        return newRect
    }
    
    private func rightViewLabelRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.rightViewRect(forBounds: bounds)
        let centerY = borderView.frame.midY

        guard let rightViewLabelText = rightViewLabel.text, !rightViewLabelText.isEmpty else {
            return CGRect.zero
        }

        let labelWidth = rightViewLabel.intrinsicContentSize.width

        var rightViewLabelRect = CGRect(
            x: superRect.origin.x - labelWidth - sideRightViewLabelHorizontalInset,
            y: centerY - rightViewLabel.intrinsicContentSize.height / 2,
            width: labelWidth,
            height: rightViewLabel.intrinsicContentSize.height
        )
        rightViewLabelRect.origin.x -= textInsets.right / 2

        return rightViewLabelRect
    }


    override public func layoutSubviews() {
        super.layoutSubviews()
        rightView?.frame = rightViewRect(forBounds: bounds)
        leftView?.frame = leftViewRect(forBounds: bounds)
        rightViewLabel.frame = rightViewLabelRect(forBounds: bounds)
        updateBorderPosition()
        updatePlaceholderPosition(animated: false)
        updateHintPosition(animated: false)
    }

    // MARK: - Public methods

    public func setHint(_ text: String?, animated: Bool = false) {
        hintLabel.text = text
        isError = false
        isSuccess = false
        updateHintPosition(animated: animated)
        updateAppearance()
    }
    
    public func setRightTextLabel(_ text: String, animated: Bool = false) {
        rightViewLabel.text = text
        updateAppearance()
    }

    public func setError(_ text: String?, animated: Bool = false) {
        hintLabel.text = text
        isError = true
        isSuccess = false
        updateHintPosition(animated: animated)
        updateAppearance()
    }

    public func setSuccess(_ text: String?, animated: Bool = false) {
        hintLabel.text = text
        isError = false
        isSuccess = true
        updateHintPosition(animated: animated)
        updateAppearance()
    }

    // MARK: - Appearance methods

    private func updateAppearance() {
        updateBackgroundAppearance()
        updateTextAppearance()
        updateBorderAppearance()
        updatePlaceholderAppearance()
        updateHintAppearance()
        updateRightViewAppearance()
        updateRightViewLabelAppearance()
    }

    private func updateBackgroundAppearance() {
        borderView.layer.backgroundColor = isEnabled ? normalBackgroundColor.cgColor : disabledBackgroundColor.cgColor
    }

    private func updateBorderAppearance() {
        borderView.layer.cornerRadius = borderCornerRadius
        borderView.layer.borderWidth = borderWidth

        borderView.layer.borderColor = !isEnabled ? disabledBorderColor.cgColor :
            isError ? errorBorderColor.cgColor :
            isSuccess ? successBorderColor.cgColor :
            isEditing ? focusedBorderColor.cgColor : normalBorderColor.cgColor
    }

    private func updateTextAppearance() {
        textColor = isEnabled ? normalTextColor : disabledTextColor
        font = textFont
    }

    private func updatePlaceholderAppearance() {
        guard placeholder != nil else {
            attributedPlaceholder = nil
            return
        }

        floatingPlaceholderLabel.font = floatingPlaceholderFont
        floatingPlaceholderLabel.textColor = isEnabled ? placeholderColor : disabledPlaceholderColor

        staticPlaceholderLabel.font = placeholderFont
        staticPlaceholderLabel.textColor = isEnabled ? placeholderColor : disabledPlaceholderColor
    }

    private func updateHintAppearance() {
        hintLabel.font = hintFont
        hintLabel.textColor = isError ? errorHintColor : isSuccess ? successHintColor : normalHintColor
    }
    
    private func updateRightViewLabelAppearance() {
        rightViewLabel.font = rightViewLabelFont
        rightViewLabel.textColor = normalRightTextLabelColor
    }

    private func updateRightViewAppearance() {
        setupImageRightView()
        setupTextRightView()

        rightAccessoryButton.frame = rightViewRect(forBounds: bounds)

        rightAccessoryButton.addTarget(self, action: #selector(rightViewTapped), for: .touchUpInside)
        rightView = rightAccessoryButton
    }

    private func setupTextRightView() {
        guard let rightViewText else { return }
        rightAccessoryButton.setTitle(rightViewText, for: .normal)
        rightAccessoryButton.titleLabel?.font = rightViewFont

        rightAccessoryButton.setTitleColor(normalRightViewTintColor, for: .normal)
        rightAccessoryButton.setTitleColor(highlightedRightViewTintColor, for: .highlighted)

        rightViewMode = .always
    }

    private func setupImageRightView() {
        guard let normalRightViewImage else { return }

        let highlightedImage = highlightedRightViewImage != nil ?
            highlightedRightViewImage :
            normalRightViewImage.withTintColor(
                highlightedRightViewTintColor,
                renderingMode: .alwaysOriginal
            )

        rightAccessoryButton.setImage(normalRightViewImage, for: .normal)
        rightAccessoryButton.setImage(highlightedImage, for: .highlighted)

        rightViewMode = .always
    }

    // MARK: - Placeholder methods

    private func setPlaceholder(_ placeholder: String?) {
        guard let placeholder else {
            attributedPlaceholder = nil
            return
        }
        floatingPlaceholderLabel.text = placeholder
        staticPlaceholderLabel.text = placeholder
        updatePlaceholderAppearance()
    }

    private func updatePlaceholderPosition(animated: Bool) {
        let leftViewPadding = (leftView?.superview == nil) ?
            floatingPlaceholderInsets.left :
            (leftView?.frame.width ?? 0) + 2 * sideViewsHorizontalInset
        let floatingFrame = CGRect(
            x: leftViewPadding,
            y: floatingPlaceholderInsets.top,
            width: bounds.width - floatingPlaceholderInsets.left - floatingPlaceholderInsets.right,
            height: placeholderFont.lineHeight
        )
        var staticFrame = textRect(forBounds: bounds)
        staticFrame = staticFrame.applying(CGAffineTransform(
            translationX: 0,
            y: -(borderHeight - staticFrame.height) / 2
        ))
        let _isFloating = !textIsEmpty() || isEditing

        let dBottom = textInsets.bottom

        let changes: (() -> Void) = { [weak self] in
            guard let self else { return }
            self.floatingPlaceholderLabel.frame = _isFloating ?
                floatingFrame :
                floatingFrame.applying(CGAffineTransform(translationX: 0, y: dBottom))
            self.floatingPlaceholderLabel.alpha = _isFloating ? 1 : 0
            self.staticPlaceholderLabel.frame = _isFloating ?
                staticFrame.applying(CGAffineTransform(translationX: 0, y: -dBottom)) :
                staticFrame.applying(CGAffineTransform(translationX: 0, y: 7))
            self.staticPlaceholderLabel.alpha = _isFloating ? 0 : 1
        }
        if animated {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: [.beginFromCurrentState, .curveEaseInOut],
                animations: changes,
                completion: nil
            )
        } else {
            changes()
        }
    }

    // MARK: - Hint methods

    private func hintHeight() -> CGFloat {
        let hintText = hintLabel.text.orEmpty
        guard !hintText.isEmpty else {
            return 0
        }

        let hintHeight = hintFont.lineHeight

        return ceil(hintHeight)
    }

    private func updateHintPosition(animated: Bool) {
        let newFrame = CGRect(
            x: hintInsets.left,
            y: borderView.frame.maxY + hintInsets.top,
            width: frame.width - hintInsets.left - hintInsets.right,
            height: hintHeight()
        )
        guard newFrame != hintLabel.frame else { return }
        let changes: (() -> Void) = { [weak self] in
            self?.invalidateIntrinsicContentSize()
            self?.hintLabel.frame = newFrame
        }
        if animated {
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: [.curveEaseInOut],
                animations: changes,
                completion: nil
            )
        } else {
            changes()
        }
    }

    // MARK: - Border methods

    private func updateBorderPosition() {
        let newFrame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: borderHeight
        )
        guard newFrame != borderView.frame else { return }
        borderView.frame = newFrame
    }

    @objc
    private func editingChanged() {
        updateAppearance()

        updatePlaceholderPosition(animated: true)
    }

    @objc
    private func rightViewTapped() {
        rightViewAction?()
    }
}
