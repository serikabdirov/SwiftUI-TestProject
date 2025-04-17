//
//  AuthorizationChecker.swift
//  Platform
//

import RxCocoa

public protocol AuthorizationChecker {
    func isAuthorized() async -> Bool
    var isAuthorizedDriver: Driver<Bool> { get }
}
