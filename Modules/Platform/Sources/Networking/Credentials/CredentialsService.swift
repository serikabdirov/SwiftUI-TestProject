//
//  CredentialsService.swift
//  Platform
//

import RxCocoa
import Networking
import KeychainAccess

public protocol CredentialsService {
    func saveToken(_ token: Token) async
    func removeToken() async
}
