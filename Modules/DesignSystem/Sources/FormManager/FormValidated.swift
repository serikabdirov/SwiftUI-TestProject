//
//  FormValidated.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 09.06.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import RxSwift

final class FormValidated<Value> {
    var value: Value? {
        didSet {
            subject.onNext(errors)
        }
    }

    var errors: [Error] {
        var errors: [Error] = []
        validators.forEach {
            do {
                try $0.validate(value: value)
            } catch {
                if let multipleError = error as? MultipleError {
                    errors.append(contentsOf: multipleError.errors)
                } else {
                    errors.append(error)
                }
            }
        }
        return errors
    }

    var subject = ReplaySubject<[Error]>.create(bufferSize: 1)

    var validators: [AnyValidator<Value>] = []
}
