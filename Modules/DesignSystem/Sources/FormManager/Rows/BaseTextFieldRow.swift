//
//  BaseTextFieldRow.swift
//
//  Created by Alexey Ostroverkhov on 09.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import UIKit
import R

public enum TextValidationOption {
    case debounce(interval: Int)
    case afterEndEditing
    case `default`
}

open class BaseTextFieldRow<ValueType>: Row<BaseTextFieldCell, ValueType>, UITextFieldDelegate {
    // MARK: - public properties

    public var callbackDidBeginEditing: (() -> Void)?
    public var callbackDidEndEditing: (() -> Void)?
    public var hintText: String?

    public var placeholder: String? {
        didSet {
            cell.textField.placeholder = placeholder
        }
    }
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            cell.textField.keyboardType = keyboardType
        }
    }

    public var autocapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            cell.textField.autocapitalizationType = autocapitalizationType
        }
    }
    
    public var spellCheckingType: UITextSpellCheckingType = .default {
        didSet {
            cell.textField.spellCheckingType = spellCheckingType
        }
    }

    public var autocorrectionType: UITextAutocorrectionType = .no {
        didSet {
            cell.textField.autocorrectionType = autocorrectionType
        }
    }

    public var validationOption: TextValidationOption = .default {
        didSet {
            setValidationOption()
        }
    }

    // MARK: - override properties

    public override weak var form: FormStackManager? {
        didSet {
            cell.textField.inputAccessoryView = form?.accessoryView
        }
    }

    // MARK: - private properties

    private var debounceSetError: ((_: [Error]) -> Void)?
    private var errors: [Error] = []

    // MARK: - init

    required public init() {
        super.init()
        cell.textField.keyboardType = keyboardType
        cell.textField.autocapitalizationType = autocapitalizationType
        cell.textField.autocorrectionType = autocorrectionType
        cell.textField.delegate = self
    }

    // MARK: - override mehods

    public override func validation(errors: [Error]) {
        self.errors = errors
        updateValidation()
    }

    public override func canBeFirstResponder() -> Bool {
        true
    }

    public override func isFirstResponder() -> Bool {
        cell.textField.isFirstResponder
    }

    public override func becomeFirstResponder() {
        cell.textField.becomeFirstResponder()
    }

    public override func resignFirstResponder() {
        cell.textField.resignFirstResponder()
    }

    // MARK: - public methods

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        callbackDidBeginEditing?()
        if case .afterEndEditing = validationOption {
            setError(errors: [])
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if showValidationError {
            setError(errors: errors)
        }

        callbackDidEndEditing?()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textFieldDidEndEditing(textField)
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return true
    }
    
    public func setError(errors: [Error]) {
        if errors.isEmpty {
            cell.textField.setHint(hintText)
        } else {
            cell.textField.setError(errors.first?.localizedDescription)
        }
    }

    public func updateValidation() {
        guard showValidationError else { return }

        switch validationOption {
        case .debounce:
            debounceSetError?(errors)
        case .afterEndEditing:
            break
        case .default:
            setError(errors: errors)
        }
    }

    // MARK: - private methods

    private func setValidationOption() {
        switch validationOption {
        case let .debounce(interval):
            debounceSetError = debounce(interval: interval, queue: .main) { [unowned self] (errors: [Error]) in
                setError(errors: errors)
            }
        case .afterEndEditing,
             .default:
            break
        }
    }
}

public final class TextFieldRow: BaseTextFieldRow<String>, FormStackRow {
    
    // MARK: - init

    required init() {
        super.init()
        cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func updateValue() {
        super.updateValue()

        cell.textField.text = value
    }

    // MARK: - actions

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let textValue = textField.text else {
            value = nil
            return
        }
        value = textValue
    }
    
    public override func canBeFirstResponder() -> Bool {
        return self.isEnabled
    }
}
