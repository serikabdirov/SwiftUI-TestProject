//
//  WorkSheetManagerServiceImpl.swift
//  Platform
//
//  Created by Александр Болотов on 20.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Networking
import RxSwift

final class ProfileBonusServiceImpl {
    
    private let apiClient: ApiClient
    private let errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>

    init(
        apiClient: ApiClient,
        errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>
    ) {
        self.apiClient = apiClient
        self.errorTranslator = errorTranslator
    }
}

extension ProfileBonusServiceImpl: ProfileBonusService {
    
    func getBonusBalance() async throws -> ProfileBonusBalance {
        try await apiClient.load(
            ProfileBonusServiceTarget.getProfileBonusBalance(),
            responseSerializer: .ballResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
}
