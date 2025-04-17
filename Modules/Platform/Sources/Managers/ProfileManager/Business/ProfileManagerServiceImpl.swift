//
//  ProfileManagerServiceImpl.swift
//  Platform
//
//  Created by Евграфов Максим on 12.11.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation
import RxSwift
import Networking

final class ProfileManagerServiceImpl: ProfileManagerService {
    
    private let apiClient: ApiClient
    private let errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>

    init(
        apiClient: ApiClient,
        errorTranslator: AnyErrorTranslator<ApiErrorModel, UnspecifiedDomainError>
    ) {
        self.apiClient = apiClient
        self.errorTranslator = errorTranslator
    }
    
    func logout() async throws {
        try await apiClient.load(
            ProfileManagerTarget.logOut(),
            responseSerializer: .ballEmptyResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
    
    func getProfile() async throws -> Profile {
        try await apiClient.load(
            ProfileManagerTarget.getProfile(),
            responseSerializer: .ballResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
    
    func updateProfile(with parameters: ProfilePatchData) async throws -> Profile {
        try await apiClient.load(
            ProfileManagerTarget.patchProfile(with: parameters),
            responseSerializer: .ballResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
    
    func updateAvatar(_ imageData: Data) async throws -> AvatarResponse {
        try await apiClient.upload(
            ProfileManagerTarget.updateAvatar(imageData),
            responseSerializer: .ballResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
    
    func deleteProfile() async throws {
        try await apiClient.load(
            ProfileManagerTarget.deleteProfile(),
            responseSerializer: .ballEmptyResponseSerializer()
        )
        .result
        .translateError(using: errorTranslator)
        .get()
    }
}
