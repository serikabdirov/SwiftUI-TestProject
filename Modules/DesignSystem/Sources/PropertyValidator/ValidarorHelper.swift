//
//  ValidarorHelper.swift
//  yourservice-ios
//
//  Created by Alexandr Byzov on 15.10.2020.
//  Copyright © 2020 spider. All rights reserved.
//

import UIKit

public struct LengthValidator<R: RangeExpression, C: Collection>: Validator where R.Bound == Int {
    var range: R
    public var errorMessage: String
    
    public init(range: R, errorMessage: String) {
        self.range = range
        self.errorMessage = errorMessage
    }
    
    public func validate(value: C?) throws {
        if !range.contains(value?.count ?? 0) {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct EqualLengthValidator<C: Collection>: Validator {
    var length: Int
    public var errorMessage: String
    
    public init(length: Int, errorMessage: String) {
        self.length = length
        self.errorMessage = errorMessage
    }
    
    public func validate(value: C?) throws {
        guard let count = value?.count else {
            throw ValidationError(message: errorMessage)
        }
            
        if count != length {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct EqualCountWordsValidator: Validator {
    var count: Int
    public var errorMessage: String
    
    public init(count: Int, errorMessage: String) {
        self.count = count
        self.errorMessage = errorMessage
    }
    
    public func validate(value: String?) throws {
        
        guard let words = value?.split(separator: " ") else {
            throw ValidationError(message: errorMessage)
        }
            
        if words.count != count {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct MinLengthValidator<C: Collection>: Validator {
    var length: Int
    public var errorMessage: String

    public init(length: Int, errorMessage: String) {
        self.length = length
        self.errorMessage = errorMessage
    }

    public func validate(value: C?) throws {
        guard let count = value?.count else {
            throw ValidationError(message: errorMessage)
        }
            
        if count < length {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct MaxLengthValidator<C: Collection>: Validator {
    var length: Int
    public var errorMessage: String

    public init(length: Int, errorMessage: String) {
        self.length = length
        self.errorMessage = errorMessage
    }

    public func validate(value: C?) throws {
        guard let count = value?.count else {
            throw ValidationError(message: errorMessage)
        }
            
        if count > length {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct RegexValidator: Validator {
    public var errorMessage: String
    private var regex: String
    public init(regex: String, errorMessage: String) {
        self.regex = regex
        self.errorMessage = errorMessage
    }
    public func validate(value: String?) throws {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: value) {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct NameValidator: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: String?) throws {
        guard let text = value else {
            return
        }
        
        if text.isEmpty {
            return
        }
        
        if text.count < 1 || text.count > 40 {
            throw ValidationError(message: "Имя должно содержать от 1 до 40 символов.")
        }
        
        var allowed = CharacterSet()
        allowed.formUnion(.letters)
        allowed.formUnion(.whitespaces)
        allowed.insert(charactersIn: "-'." )
        
        let characterSet = CharacterSet(charactersIn: text)
        
        if !allowed.isSuperset(of: characterSet) {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct NicknameValidator: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: String?) throws {
        guard let text = value else {
            return
        }
        
        if text.isEmpty {
            return
        }
        
        if text.count < 3 || text.count > 25 {
            throw ValidationError(message: "Никнейм должен содержать от 3 до 25 символов.")
        }
        
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._")
        let characterSet = CharacterSet(charactersIn: text)
        if !allowed.isSuperset(of: characterSet) {
            throw ValidationError(message: "Никнейм содержит недопустимые символы.")
        }
        
        let letterCharacterSet = CharacterSet.letters
        if text.rangeOfCharacter(from: letterCharacterSet) == nil {
            throw ValidationError(message: "Никнейм должен содержать хотя бы одну букву.")
        }
    }
}


public struct NotEmptyValidator<C: Collection>: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: C?) throws {
        if value?.isEmpty != false {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct EmailValidator: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: String?) throws {
        guard let value = value, !value.isEmpty else {
            return
        }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: value) {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct NotNilValidator<Value>: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: Value?) throws {
        if value == nil {
            throw ValidationError(message: errorMessage)
        }
    }
}

public struct DateValidator: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: Date?) throws {
        guard let birthDate = value else {
            throw ValidationError(message: errorMessage)
        }
        
        let currentDate = Date()
        
        if birthDate > currentDate {
            throw ValidationError(message: "Дата не может быть позже текущей")
        }
    }
}

public struct PositiveNumberValidator: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: Double?) throws {
        guard let value = value else { return }
        
        guard value > 0 else {
            throw ValidationError(message: "Значение не может быть меньше или равно 0")
        }
    }
}


public struct FavoriteFieldValidator: Validator {
    public var errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(value: String?) throws {
        guard let text = value else {
            return
        }
        
        if text.isEmpty {
            return
        }
        if text.count < 2 || text.count > 100 {
            throw ValidationError(message: "Текст должен быть от 2 до 100 символов.")
        }
    }
}
