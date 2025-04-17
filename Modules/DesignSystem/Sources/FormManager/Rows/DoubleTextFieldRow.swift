//
//  DoubleTextFieldRow.swift
//  DesignSystem
//
//  Created by Vladislav on 08.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//
import UIKit

public final class DoubleTextFieldRow: BaseTextFieldRow<Double>, FormStackRow {
    
    // MARK: - init
        
    public let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    private var formattedValue: String {
        guard let value = self.value as? NSNumber else { return "" }
        guard let textValue = self.numberFormatter.string(from: value) else { return "" }
        return textValue
    }

    required init() {
        super.init()
        cell.textField.keyboardType = .decimalPad
        cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func updateValue() {
        super.updateValue()
        if shouldDropLast() {
            cell.textField.text = String((cell.textField.text ?? "").dropLast())
        }
    }
    
    private func shouldDropLast() -> Bool {
        let text = cell.textField.text ?? ""
        let separated = text.components(separatedBy: self.numberFormatter.decimalSeparator)
        if separated.count == 2 {
            let digits = separated[1]
            return digits.count > self.numberFormatter.maximumFractionDigits
        }
        else if separated.count > 2 {
            return true
        }
        return false
    }

    // MARK: - actions

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let textValue = textField.text, !textValue.isEmpty else {
            value = nil
            return
        }
        value = self.numberFormatter.number(from: textValue) as? Double
    }
    
    public override func canBeFirstResponder() -> Bool {
        return self.isEnabled
    }
}
