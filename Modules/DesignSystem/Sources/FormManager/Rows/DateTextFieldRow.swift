//
//  DateTextFieldRow.swift
//  quickmoney
//
//  Created by Марина Айбулатова on 14.08.2023.
//  Copyright © 2023 quickmoney. All rights reserved.
//

import UIKit

public final class DateTextFieldRow: BaseTextFieldRow<Date>, FormStackRow {
    // MARK: - public properties

    private var currentVC = UIViewController.topMostController()
    var imageButtonTapped: (() -> Void)?
    
    var formatter = DateFormatter.dayFormatter
    var showRightView: Bool? {
        didSet {
            addRightView()
        }
    }

    public let datePicker = UIDatePicker(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 216)
        )
    )

    public var mode: UIDatePicker.Mode = .date {
        didSet {
            datePicker.datePickerMode = mode
        }
    }

    public var minimumDate: Date? {
        didSet {
            datePicker.minimumDate = minimumDate
        }
    }

    public var maximumDate: Date? {
        didSet {
            datePicker.maximumDate = maximumDate
        }
    }

    // MARK: - init

    required init() {
        super.init()

        self.formatter = DateFormatter.dayFormatter
        datePicker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = UIColor.Green._90
        datePicker.backgroundColor = .white
        datePicker.frame.size.height = 330
        datePicker.datePickerMode = .date
        cell.textField.inputView = datePicker
        cell.textField.tintColor = .clear
    }

    private func addRightView() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cell.textField.rightView = button
        cell.textField.rightViewMode = .always
    }

    @objc
    private func buttonTapped() {
        imageButtonTapped?()
    }

    // MARK: - override mehods
    
    public override var isEnabled: Bool {
        didSet {
            cell.textField.isEnabled = isEnabled
        }
    }

    override func updateValue() {
        super.updateValue()

        if let value = value {
            cell.textField.text = formatter.string(from: value)
        } else {
            cell.textField.text = nil
        }
    }

    public override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)

        if let date = value {
            datePicker.setDate(date, animated: false)
        }
    }

    // MARK: - actions

    @objc
    private func dateDidChange(_ sender: UIDatePicker) {
        value = sender.date
        cell.textField.text = formatter.string(for: sender.date)
    }
}

extension UIAlertController {
    func addImage(image: UIImage) {
        let alert = UIAlertAction(title: "", style: .default)
        alert.isEnabled = false
        alert.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")
        addAction(alert)
    }
}
