//
//  FormStackManager.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 08.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import UIKit

public final class FormStackManager: NSObject {
    // MARK: - public properties

    public var accessoryView: UIView!
    public var nextButton: UIBarButtonItem!
    public var closeButton: UIBarButtonItem!

    public var callbackOnValidationChanged: (() -> Void)?

    public var isHidden = false {
        didSet {
            stackView.isHidden = isHidden
        }
    }

    public var alpha: CGFloat = 1.0 {
        didSet {
            stackView.alpha = alpha
        }
    }

    public var isValid: Bool {
        sections.filter { !$0.isHidden }.reduce(true) {
            $0 && $1.isValid
        }
    }

    public var spacing: CGFloat = .zero {
        didSet {
            stackView.spacing = spacing
        }
    }

    public var allRows: [BaseRow] {
        sections.reduce([BaseRow]()) { result, section -> [BaseRow] in
            var result = result
            result.append(contentsOf: section.allRows)
            return result
        }
    }

    public var allVisibleRows: [BaseRow] {
        visibleSections.reduce([BaseRow]()) { result, section -> [BaseRow] in
            var result = result
            result.append(contentsOf: section.allVisibleRows)
            return result
        }
    }

    public var visibleSections: [FormSection] {
        sections.filter { !$0.isHidden }
    }

    private(set) var stackView: UIStackView
    private(set) var sections: [FormSection] = []

    // MARK: - init

    public init(stackView: UIStackView, _ customize: (FormStackManager) -> Void = { _ in }) {
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        self.stackView = stackView
        super.init()
        customize(self)
        //self.accessoryView = createAccessoryView()
    }

    @discardableResult
    public func append(section: FormSection) -> FormStackManager {
        section.form = self
        sections.append(section)
        stackView.addArrangedSubview(section.view)
        return self
    }

    // вызывать из row
    func validationChanged() {
        callbackOnValidationChanged?()
    }

    public func onValidationChanged(_ callback: @escaping (Self) -> Void) -> Self {
        callbackOnValidationChanged = { [unowned self] in callback(self) }
        return self
    }

    public func section(id: String?) -> FormSection? {
        guard let id = id else {
            return nil
        }

        return sections.first { section -> Bool in
            section.id == id
        }
    }

    public func hideSection(id: String?) {
        section(id: id)?.hide()
    }

    public func showSection(id: String?) {
        section(id: id)?.show()
    }

    public func hideSections(ids: String?...) {
        for id in ids {
            hideSection(id: id)
        }
    }

    public func showSections(ids: String?...) {
        for id in ids {
            showSection(id: id)
        }
    }

    public func hideRow(id: String?) {
        row(id: id)?.hide()
    }

    public func showRow(id: String?) {
        row(id: id)?.show()
    }

    public func row(id: String?) -> BaseRow? {
        guard let id = id else {
            return nil
        }

        for section in sections {
            if let row = section.row(id: id) {
                return row
            }
        }

        return nil
    }

    // MARK: - private methods

//    private func createAccessoryView() -> UIView {
//        DesignSystem.accessoryCloseNextView(
//            target: self,
//            nextAction: #selector(nextButtonTapped),
//            closeAction: #selector(closeButtonTapped)
//        ).0
//    }

    private func findCurrentResponder() -> BaseRow? {
        allVisibleRows.first { $0.isFirstResponder() }
    }

    private func findNextResponderRow() -> BaseRow? {
        guard
            let current = findCurrentResponder(),
            let currentIndex = allVisibleRows.firstIndex(of: current)
        else {
            return nil
        }

        var nextRowIndex: Int? = nil
        let offset = current.canStayFirstResponder() ? .zero : 1
        for i in (currentIndex + offset) ..< allVisibleRows.count {
            if allVisibleRows[i].canBeFirstResponder() {
                nextRowIndex = i
                break
            }
        }

        if let next = nextRowIndex {
            return allVisibleRows[next]
        }

        return nil
    }

    // MARK: - actions

    @objc
    private func nextButtonTapped() {
        if let nextResponder = findNextResponderRow() {
            nextResponder.becomeFirstResponder()
            return
        }

        findCurrentResponder()?.resignFirstResponder()
    }

    @objc
    private func closeButtonTapped() {
        findCurrentResponder()?.resignFirstResponder()
    }
}
