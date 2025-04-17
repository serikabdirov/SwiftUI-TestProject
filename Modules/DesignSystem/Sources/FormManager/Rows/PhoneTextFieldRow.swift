
//
//  Created by Alexandr Byzov on 19.10.2020.
//  Copyright © 2020 spider. All rights reserved.
//

import UIKit
import DITranquillity
import R


public final class PhoneTextFieldRow: Row<PhoneTextFieldCell, String>, FormStackRow, UITextFieldDelegate {
    // MARK: - public properties
    
    var callbackDidBeginEditing: (() -> Void)?
    var callbackDidEndEditing: (() -> Void)?
    public var getNumber: String?
    public var formattedNumber: String?
    
    var text: String? {
        didSet {
            cell.textField.text = text
        }
    }
    
    var isValidNumber: Bool {
        cell.textField.isValidNumber
    }
    
    var titleLabelText: String? {
        didSet { cell.textField.titleLabelText = titleLabelText }
    }
    
    // MARK: - private properties
    
    private var errors: [Error] = []
    private var firstEdining = true
    
    // MARK: - init
    
    public required init() {
        super.init()
        cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cell.textField.delegate = self
        isChangedValue = true
        
        let country = CountryManager.shared.currentCountry ?? CountryManager.shared.country(withCode: "LU")
        cell.textField.flag = country?.flag
        cell.textField.code = country?.phoneCode        
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
    
    override public func becomeFirstResponder() {
        cell.textField.becomeFirstResponder()
    }
    
    override public func resignFirstResponder() {
        cell.textField.resignFirstResponder()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        firstEdining = false
        
        if showValidationError {
            setError(errors: errors)
        }
        callbackDidEndEditing?()
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        true
    }
    
    public func setError(errors: [Error]) {
        if errors.isEmpty {
            cell.textField.setError(nil)
        } else {
            cell.textField.setError(errors.first?.localizedDescription)
        }
    }
    
    func updateValidation() {
        if !showValidationError {
            return
        }
        if firstEdining {
            return
        }
        
        setError(errors: errors)
    }
    
    override func updateValue() {
        if let text = value {
            let formatter = cell.textField.partialFormatter
            let formattedPhone = formatter.formatPartial(text)
            cell.textField.text = formattedPhone
        }
        super.updateValue()
    }
    
    // MARK: - actions
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let textValue = textField.text else {
            value = nil
            return
        }
        
        let formatter = cell.textField.partialFormatter
        value = formatter.formatPartial(textValue)
        formattedNumber = value
        
        if let countryCode = cell.textField.code {
            let rawPhoneNumber = value?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            getNumber = "\(countryCode)\(rawPhoneNumber ?? "")"
            formattedNumber = "\(countryCode + " " + (value ?? ""))"
        } else {
            getNumber = value?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            formattedNumber = "\(String(describing: value))"
        }        
    }
}
