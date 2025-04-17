//
//  Row.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 08.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import RxSwift
import UIKit

public protocol FormStackRow {
    init(_ initializer: (Self) -> Void)
}

open class BaseRow: NSObject {
    // MARK: - public properties

    public var callbackOnChange: (() -> Void)?
    public var callbackOnChangeValidValue: (() -> Void)?
    public var callbackOnTouch: (() -> Void)?

    public var id: String?

    public var isValid: Bool {
        true
    }

    public var showValidationError = true
    public var enableValidation = true {
        didSet {
            form?.validationChanged()
        }
    }

    public var isHidden = false {
        didSet {
            view.isHidden = isHidden
            form?.validationChanged()
        }
    }

    public var isEnabled = true {
        didSet {
            view.isUserInteractionEnabled = isEnabled
        }
    }

    public var view: UIView!

    public var spaceAfter: CGFloat? = nil

    public weak var form: FormStackManager? {
        didSet {
            form?.validationChanged()
        }
    }

    public weak var section: FormSection?

    // MARK: - init

    public override required init() {
        super.init()
    }

    public func configure() {}

    public func canBeFirstResponder() -> Bool {
        false
    }

    public func canStayFirstResponder() -> Bool {
        false
    }

    public func isFirstResponder() -> Bool {
        false
    }

    public func becomeFirstResponder() {}

    public func resignFirstResponder() {}

    public func hide() {
        isHidden = true
    }

    public func show() {
        isHidden = false
    }
}

public extension FormStackRow where Self: BaseRow {
    init(_ initializer: (Self) -> Void) {
        self.init()
        configure()
        initializer(self)
    }

    func toProperty(_ row: inout Self?) {
        row = self
    }

    @discardableResult
    func onChange(_ callback: @escaping (Self) -> Void) -> Self {
        callbackOnChange = { [unowned self] in callback(self) }
        return self
    }

    @discardableResult
    func onChangeValidValue(_ callback: @escaping (Self) -> Void) -> Self {
        callbackOnChangeValidValue = { [unowned self] in callback(self) }
        return self
    }

    @discardableResult
    func onTouch(_ callback: @escaping (Self) -> Void) -> Self {
        callbackOnTouch = { [unowned self] in callback(self) }
        return self
    }
}

open class Row<CellType: Cell, ValueType>: BaseRow {
    // MARK: - public properties

    public var value: ValueType? {
        didSet {
            updateValue()
        }
    }
    
    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            cell.contentInsets = contentInsets
        }
    }
    
    // TODO: what's this property do exactly? It's never set to false again
    public var isChangedValue = false

    public let cell = CellType()

    public override var isValid: Bool {
        enableValidation ? formValidator.errors.isEmpty : true
    }

    // MARK: - private properties

    private var formValidator = FormValidated<ValueType>()

    public required init() {
        super.init()
        view = cell
        cell.addTarget(
            self,
            action: #selector(tappedAction),
            for: .touchUpInside
        )
    }

    // MARK: - public methods

    // override to validate
    public func validation(errors: [Error]) {}

    // validator
    @discardableResult
    public func addValidator(_ validator: AnyValidator<ValueType>) -> Self {
        formValidator.validators.append(validator)
        updateValue()
        return self
    }

    public func removeValidator(at index: Int) {
        formValidator.validators.remove(at: index)
        updateValue()
    }

    internal func updateValue() {
        if value != nil {
            isChangedValue = true
        }
        formValidator.value = value
        if isChangedValue {
            validation(errors: formValidator.errors)
        }
        callbackOnChange?()
        if isValid {
            callbackOnChangeValidValue?()
        }
        form?.validationChanged()
    }

    // MARK: - actions

    @objc
    func tappedAction() {
        callbackOnTouch?()
    }
}

// container row
public final class MultipleRow: BaseRow {
    // MARK: - public properties

    var spacing: CGFloat = 8 {
        didSet {
            stackView.spacing = spacing
        }
    }

    var alignment: UIStackView.Alignment = .fill {
        didSet {
            stackView.alignment = alignment
        }
    }

    var distribution: UIStackView.Distribution = .fillEqually {
        didSet {
            stackView.distribution = distribution
        }
    }

    // update in init closure
    var insets: UIEdgeInsets

    private(set) var stackView: UIStackView!
    private(set) var rows: [BaseRow] = []

    // MARK: - init

    init(_ customize: ((MultipleRow) -> Void)? = nil) {
        self.stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        self.insets = .zero
        super.init()
        customize?(self)
        setup()
    }

    required init() {
        self.spacing = 8
        self.alignment = .fill
        self.distribution = .fillEqually
        self.insets = .zero
        super.init()
        setup()
    }

    // MARK: - public methods

    @discardableResult
    func append(row: BaseRow) -> MultipleRow {
        row.form = form
        rows.append(row)
        stackView.addArrangedSubview(row.view)
        return self
    }

    func setup() {
        view = {
            let i = UIView()
            return i
        }()

        stackView = {
            let i = UIStackView()
            i.axis = .horizontal
            i.spacing = spacing
            i.alignment = alignment
            i.distribution = distribution
            return i
        }()

        view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.equalTo(insets.top)
            $0.leading.equalTo(insets.left)
            $0.trailing.equalTo(-insets.right)
            $0.bottom.equalTo(-insets.bottom)
        }
    }
}
