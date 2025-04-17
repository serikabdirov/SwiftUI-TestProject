//
//  PushService.swift
//  Platform
//
//  Created by Zart Arn on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

protocol PushService {
    func registerDevice(token: String) async
    func unRegisterDevice(token: String) async
}

final class PushServiceImpl {
    private let apiClient: ApiClient

    init(
        apiClient: ApiClient
    ) {
        self.apiClient = apiClient
    }
}

extension PushServiceImpl: PushService {
    func registerDevice(token: String) async {
        try? await apiClient.load(
            PushServiceTarget.registerDevice(token: token),
            responseSerializer: .ballEmptyResponseSerializer()
        )
        .result.get()
    }
    
    func unRegisterDevice(token: String) async {
        try? await apiClient.load(
            PushServiceTarget.unRegisterDevice(token: token),
            responseSerializer: .ballEmptyResponseSerializer()
        )
        .result.get()
    }
}
