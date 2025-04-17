//
//  WorkSheetManagerServiceImpl.swift
//  Platform
//
//  Created by Александр Болотов on 20.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Networking
import RxSwift

final class WorkSheetManagerServiceImpl {
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

extension WorkSheetManagerServiceImpl: WorkSheetManagerService {
    func getQuestionnaire() async throws -> QuestionnaireModel? {
        do {
            return try await apiClient.load(
                WorkSheetManagerServiceTarget.getQuestionnaire(),
                responseSerializer: .ballResponseSerializer()
            )
            .result
            .translateError(using: errorTranslator)
            .get()

        } catch {
            if let domainError = error as? UnspecifiedDomainError,
               let apiErrorModel = domainError.underlyingComposableError as? ApiErrorModel,
               apiErrorModel.httpStatusCode == 404
            {
                return nil
            } else {
                throw error
            }
        }
    }
}
