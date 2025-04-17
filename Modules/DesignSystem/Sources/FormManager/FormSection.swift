//
//  FormSection.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 09.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import UIKit

public class FormSection: NSObject {
    // MARK: - public properties
    
    public var spacing: CGFloat = .zero {
        didSet {
            stackView.spacing = spacing
        }
    }

    public var id: String?

    public var backgroundView: (() -> UIView)? = nil
    public var stackView: UIStackView
    
    public var axis: NSLayoutConstraint.Axis = .vertical {
        didSet {
            stackView.axis = axis
        }
    }

    public var alignment: UIStackView.Alignment = .fill {
        didSet {
            stackView.alignment = alignment
        }
    }

    public var distribution: UIStackView.Distribution = .fill {
        didSet {
            stackView.distribution = distribution
        }
    }

    public var isHidden = false {
        didSet {
            view.isHidden = isHidden
            form?.validationChanged()
        }
    }

    // update in init closure
    public var insets: UIEdgeInsets = .zero

    public var isValid: Bool {
        allVisibleRows.reduce(true) {
            $0 && $1.isValid
        }
    }

    public weak var form: FormStackManager? {
        didSet {
            allRows.forEach {
                $0.form = form
            }
        }
    }

    public var allRows: [BaseRow] {
        var array: [BaseRow] = []

        for row in tempRows {
            if let multipleRow = row as? MultipleRow {
                array.append(multipleRow)
                array.append(contentsOf: multipleRow.rows)
            }
            array.append(row)
        }

        return array
    }

    public var allVisibleRows: [BaseRow] {
        allRows.filter { !$0.isHidden }
    }

    public private(set) var view: UIView!

    // MARK: - private properties

    private var tempRows: [BaseRow] = []

    // MARK: - init

    public init(_ customize: ((FormSection) -> Void)? = nil) {
        self.stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        super.init()
        configurable()
        setupView()
        customize?(self)
        setupConstraints()
    }

    // MARK: - public methods

    @discardableResult
    public func append(row: BaseRow) -> FormSection {
        row.form = form
        row.section = self
        tempRows.append(row)
        stackView.addArrangedSubview(row.view)
        if let space = row.spaceAfter {
            stackView.setCustomSpacing(space, after: row.view)
        }

        return self
    }

    public func configurable() {}

    public func hide() {
        isHidden = true
    }

    public func show() {
        isHidden = false
    }

    public func to(variable: inout FormSection?) {
        variable = self
    }

    public func hideRow(id: String?) {
        row(id: id)?.hide()
    }

    public func showRow(id: String?) {
        row(id: id)?.show()
    }

    public func hideRows(ids: String?...) {
        for id in ids {
            hideRow(id: id)
        }
    }

    public func showRows(ids: String?...) {
        for id in ids {
            showRow(id: id)
        }
    }

    public func row(id: String?) -> BaseRow? {
        guard let id = id else {
            return nil
        }
        if let row = allRows.first(where: { $0.id == id }) {
            return row
        }

        return nil
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view = backgroundView?() ?? UIView()
        view.addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(insets.top)
            $0.leading.equalTo(insets.left)
            $0.trailing.equalTo(-insets.right)
            $0.bottom.equalTo(-insets.bottom)
        }
    }
}
