//
//  Operators.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 09.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

infix operator +++: AdditionPrecedence

@discardableResult
public func +++ (left: FormStackManager, right: FormSection) -> FormSection {
    left.append(section: right)
    return right
}

@discardableResult
public func +++ (left: FormSection, right: FormSection) -> FormSection {
    left.form?.append(section: right)
    return right
}

@discardableResult
public func +++ (left: MultipleRow, right: FormSection) -> FormSection {
    left.form?.append(section: right)
    return right
}

infix operator <<<: AdditionPrecedence

@discardableResult
public func <<< (left: FormSection, right: BaseRow) -> FormSection {
    left.append(row: right)
    return left
}

@discardableResult
public func <<< (left: FormSection, right: MultipleRow) -> MultipleRow {
    left.append(row: right)
    return right
}

@discardableResult
public func <<< (left: MultipleRow, right: BaseRow) -> FormSection {
    left.section!.append(row: right)
    return left.section!
}

infix operator <++: AdditionPrecedence

@discardableResult
public func <++ (left: MultipleRow, right: BaseRow) -> MultipleRow {
    left.append(row: right)
    return left
}
