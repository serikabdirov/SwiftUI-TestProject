//
//  BorderTextField.swift
//  DesignSystem
//
//  Created by Vladislav on 17.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

public extension UITextField {
    func textIsEmpty() -> Bool {
        guard let text else {
            return true
        }
        return text.isEmpty
    }
}

public class BorderTextField: UITextField {
    // MARK: - Public properties
    
    /// Цвет фона для поля ввода, по умолчанию отсутствует
    var normalContentBackgroundColor: UIColor? = nil {
        didSet { updateContentBackgroundColor() }
    }
    
    var disabledContentBackgroundColor: UIColor? = nil {
        didSet { updateContentBackgroundColor() }
    }
    
    
        
    // MARK: - Text properties
    
    var textInsets = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12) {
        didSet {
            if textInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }
    
    /// Горизонтальный inset для текста - задается в методе textRect (при наличии rightView / leftView)
    var sideViewTextInset: CGFloat = 8 {
        didSet {
            if sideViewTextInset != oldValue {
                setNeedsLayout()
                layoutIfNeeded()
            }
        }
    }

    /// Горизонтальный inset для leftView и rightView - задается в методе leftViewRect / rightViewRect (при наличии rightView / leftView)
    var sideViewInset: CGFloat = 8 {
            didSet {
                if sideViewInset != oldValue {
                    setNeedsLayout()
                    layoutIfNeeded()
                }
            }
        }
    
    var normalTextColor: UIColor = .black {
        didSet { updateTextAppearance() }
    }
    
    var disabledTextColor: UIColor = .gray {
        didSet { updateTextAppearance() }
    }
    
    // MARK: - Border properties
    
    var borderColor: UIColor = .black {
        didSet { updateBorderAppearance() }
    }
    
    var disabledBorderColor: UIColor = .gray {
        didSet { updateBorderAppearance() }
    }
    
    var focusedBorderColor: UIColor = .lightGray {
        didSet { updateBorderAppearance() }
    }
    
    var errorBorderColor: UIColor = .red {
        didSet { updateBorderAppearance() }
    }
    
    /// Высота поля для ввода без подсказки/ошибки
    var borderHeight: CGFloat = 44 {
        didSet {
            if borderHeight != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }
    
    var borderWidth: CGFloat = 1 {
        didSet { updateBorderAppearance() }
    }
    
    var borderCorderRadius: CGFloat = 10 {
        didSet { updateBorderAppearance() }
    }
    
    // MARK: - Placeholder properties
    
    var placeholderColor: UIColor = .black {
        didSet { updatePlaceholderAppearance() }
    }
    
    var disabledPlaceholderColor: UIColor = .gray {
        didSet { updatePlaceholderAppearance() }
    }
    
    var placeholderFont: UIFont = .systemFont(ofSize: 14) {
        didSet { updatePlaceholderAppearance() }
    }
    
    // MARK: - Hint/Error properties
    
    var hintColor: UIColor = .gray {
        didSet { updateHintAppearance() }
    }
    
    var disabledHintColor: UIColor = .lightGray {
        didSet { updateHintAppearance() }
    }
    
    var errorColor: UIColor = .red {
        didSet { updateHintAppearance() }
    }
    
    /// Шрифт для текста подсказки/ошибки
    var hintFont: UIFont = .systemFont(ofSize: 10) {
        didSet { updateHintAppearance() }
    }
    
    /// Расстояние между подсказкой/ошибкой и текстом
    var hintInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 8) {
        didSet {
            if hintInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Title label properties
    
    var titleLabelColor: UIColor = .black {
        didSet { updateTitleLabel() }
    }
    
    var titleLabelFont: UIFont = .systemFont(ofSize: 10) {
        didSet { updateTitleLabel() }
    }
    
    var titleLabelInsets = UIEdgeInsets(top: 2, left: 0, bottom: 10, right: 8) {
        didSet {
            if titleLabelInsets != oldValue {
                invalidateIntrinsicContentSize()
                layoutIfNeeded()
            }
        }
    }
    
    public var titleLabelText: String? {
        didSet { updateTitleLabel() }
    }
    
    // MARK: - Override properties
    
    override public var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width
        var hintHeight = hintHeight()
        var titleHeight = titleHeight()
        if hintHeight > 0 {
            hintHeight += hintInsets.top + hintInsets.bottom
        }
        if titleHeight > 0 {
            titleHeight += titleLabelInsets.top + titleLabelInsets.bottom
        }
        return CGSize(width: width, height: borderHeight + hintHeight + titleHeight)
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
    
    private var staticPlaceholderLabel: UILabel!
    private var hintLabel: UILabel!
    private var borderView: UIView!
    private var clearButton: UIButton!
    
    private var titleLabel: UILabel!
    
    private var isError = false
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        
        let leftViewPadding = (leftView?.superview == nil) ? textInsets.left : sideViewTextInset
        let rightViewPadding = (rightView?.superview == nil) ? textInsets.right : sideViewTextInset
        
        let textHeight = font?.lineHeight ?? 0
        let centerY = (borderHeight - textHeight)/2
        
        let newBounds = CGRect(
            x: superRect.origin.x + leftViewPadding,
            y: centerY,
            width: superRect.width - leftViewPadding - rightViewPadding,
            height: textHeight
        )
        
        return newBounds
    }
    
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
        superRect.origin.x += sideViewInset
        
        return superRect
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var superRect = super.rightViewRect(forBounds: bounds)
        let centerY = borderView.frame.midY
        superRect.origin.y = centerY - superRect.height / 2
        superRect.origin.x -= sideViewInset
        return superRect
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        rightView?.frame = rightViewRect(forBounds: bounds)
        updateBorderPosition()
        updateHintPosition(animated: false)
        updateTitleLabel()
        updatePlaceholderPosition()
    }
    
    // MARK: - Public methods
    
    public func setHint(_ text: String?, animated: Bool = false) {
        hintLabel.text = text
        isError = false
        updateHintPosition(animated: animated)
        updateAppearance()
    }
    
    public func setError(_ text: String?, animated: Bool = false) {
        hintLabel.text = text
        isError = text != nil
        updateHintPosition(animated: animated)
        updateAppearance()
    }
    
    // MARK: - Private methods
    
    private func configureViews() {
        staticPlaceholderLabel = {
            let i = UILabel()
            i.numberOfLines = 1
            i.textAlignment = .left
            i.layer.anchorPoint = .zero
            i.isUserInteractionEnabled = false
            return i
        }()
        
        hintLabel = {
            let i = UILabel()
            i.numberOfLines = 1
            i.font = hintFont
            i.textColor = hintColor
            i.textAlignment = .left
            i.isUserInteractionEnabled = false
            return i
        }()
        
        borderView = {
            let i = UIView()
            i.backgroundColor = .clear
            i.isUserInteractionEnabled = false
            return i
        }()
        
        clearButton = {
            let i = UIButton()
            i.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            return i
        }()
        
        titleLabel = {
            let i = UILabel()
            i.numberOfLines = 1
            i.font = titleLabelFont
            i.textColor = titleLabelColor
            i.textAlignment = .left
            i.isUserInteractionEnabled = false
            i.text = titleLabelText
            return i
        }()
        
        contentVerticalAlignment = .top
        borderStyle = .none
        clearButtonMode = .never
        rightViewMode = .never
        
        rightView = clearButton
        addSubview(borderView)
        addSubview(staticPlaceholderLabel)
        addSubview(hintLabel)
        addSubview(titleLabel)
        
        addTarget(self, action: #selector(editingChanged), for: .allEditingEvents)
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        updateTextAppearance()
        updateBorderAppearance()
        updatePlaceholderAppearance()
        updateHintAppearance()
        updateContentBackgroundColor()
        updateTitleLabel()
    }
    
    private func updateTitleLabel() {
        let newFrame = CGRect(
            x: titleLabelInsets.left,
            y: 0,
            width: bounds.width - 2 * sideViewInset,
            height: titleHeight()
        )
        
        titleLabel.frame = newFrame
        titleLabel.text = titleLabelText
        titleLabel.font = titleLabelFont
    }
    
    private func updateContentBackgroundColor() {
        borderView.backgroundColor = isEnabled ? normalContentBackgroundColor : disabledContentBackgroundColor
    }
    
    private func updateTextAppearance() {
        textColor = isEnabled ? normalTextColor : disabledTextColor
    }
    
    private func updateBorderAppearance() {
        borderView.layer.borderWidth = borderWidth
        if !isEnabled {
            borderView.layer.borderColor = disabledBorderColor.cgColor
        } else if isError {
            borderView.layer.borderColor = errorBorderColor.cgColor
            
        } else {
            borderView.layer.borderColor = (isEditing ? focusedBorderColor : borderColor).cgColor
        }
        borderView.layer.cornerRadius = borderCorderRadius
    }
    
    private func updatePlaceholderAppearance() {
        guard placeholder != nil else {
            attributedPlaceholder = nil
            return
        }
        let textColor = isEnabled ? placeholderColor : disabledPlaceholderColor
        
        staticPlaceholderLabel.font = font
        staticPlaceholderLabel.textColor = textColor
    }
    
    private func updatePlaceholderPosition() {
        let staticFrame = textRect(forBounds: bounds)
        let isFloating = if !textIsEmpty() || isEditing {
            true
        } else {
            false
        }
        let changes: (() -> Void) = { [weak self] in
            guard let self else { return }
            
            self.staticPlaceholderLabel.frame = staticFrame
            self.staticPlaceholderLabel.alpha = isFloating ? 0 : 1
        }
        
        changes()
    }
    
    private func updateHintAppearance() {
        hintLabel.font = hintFont
        hintLabel.textColor = isError ? errorColor : (isEnabled ? hintColor : disabledHintColor)
    }
    
    private func hintHeight() -> CGFloat {
        let hintText = hintLabel.text ?? ""
        guard !hintText.isEmpty else {
            return 0
        }
        let hintHeight: CGFloat = hintText.height(
            withConstrainedWidth: bounds.width - hintInsets.left - hintInsets.right,
            font: hintFont
        )
        return ceil(hintHeight)
    }
    
    private func titleHeight() -> CGFloat {
        let titleLabelText = titleLabel.text ?? ""
        guard !titleLabelText.isEmpty else {
            return 0
        }
        let titleHeight: CGFloat = titleLabelText.height(
            withConstrainedWidth: bounds.width - titleLabelInsets.left - titleLabelInsets.right,
            font: hintFont
        )
        return ceil(titleHeight)
    }
    
    private func updateHintPosition(animated: Bool) {
        let newFrame = CGRect(
            x: hintInsets.left,
            y: borderView.frame.maxY + hintInsets.top,
            width: bounds.width - hintInsets.left - hintInsets.right,
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
    
    private func updateBorderPosition() {
        let y0 = titleHeight() == 0 ? 0 : titleHeight() + titleLabelInsets.top + titleLabelInsets.bottom
        
        let newFrame = CGRect(
            x: 0,
            y: y0,
            width: bounds.width,
            height: borderHeight
        )
        guard newFrame != borderView.frame else { return }
        borderView.frame = newFrame
    }
    
    private func setPlaceholder(_ text: String?) {
        guard let text else {
            attributedPlaceholder = nil
            return
        }
        staticPlaceholderLabel.text = text
        updatePlaceholderAppearance()
    }
    
    @objc
    private func clearButtonTapped() {
        text = nil
        sendActions(for: .editingChanged)
    }
    
    public func clearCustomButtonTapped() {
        text = nil
        sendActions(for: .editingChanged)
    }
    
    @objc
    private func editingChanged() {
        updateAppearance()
    }    
}
