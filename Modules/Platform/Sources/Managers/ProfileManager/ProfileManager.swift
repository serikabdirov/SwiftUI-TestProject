//
//  ProfileManager.swift
//  Platform
//
//  Created by Zart Arn on 07.08.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Networking
import RxCocoa
import RxSwift

public protocol UserSettings {
    var preferences: ProfilePreferences? { get }
}

public protocol ProfileManager {
    /// Драйвер для публикации изменений профиля
    var profileDriver: Driver<Profile?> { get }
    /// Получение актуального профиля
    var profile: Profile? { get }
    /// Очистка данных пользователя (и учетных данных)
    func clearUserData()
    /// Logout
    func logout() async throws
    /// Получение профиля
    func getProfile() async throws -> Profile
    /// Обновление профиля
    func updateProfile(with parameters: ProfilePatchData) async throws -> Profile
    /// Обновление автара
    func updateAvatar(_ imageData: Data) async throws -> URL?
    /// Удаление профиля
    func deleteProfile() async throws
}

final class ProfileManagerImpl: ProfileManager, UserSettings {
    
    let profileRelay = BehaviorRelay<Profile?>(value: nil)
    lazy var profileDriver: Driver<Profile?> = profileRelay.asDriver()
    var profile: Profile? { profileRelay.value }
    var preferences: ProfilePreferences? { profile?.preferences }
    
    private var credentials: CredentialsService
    private let profileManagerService: ProfileManagerService

    init(
        credentials: CredentialsService,
        profileManagerService: ProfileManagerService
    ) {
        self.credentials = credentials
        self.profileManagerService = profileManagerService
    }

    func logout() async throws {
        try await profileManagerService.logout()
        clearUserData()
    }

    func clearUserData() {
        Task {
            await credentials.removeToken()
        }
    }

    func getProfile() async throws -> Profile {
        let fetchedProfile = try await profileManagerService.getProfile()
        profileRelay.accept(fetchedProfile)
        return fetchedProfile
    }

    func deleteProfile() async throws {
        try await profileManagerService.deleteProfile()
        clearUserData()
    }

    func updateProfile(with parameters: ProfilePatchData) async throws -> Profile {
        let updatedProfile = try await profileManagerService.updateProfile(with: parameters)
        profileRelay.accept(updatedProfile)
        return updatedProfile
    }

    func updateAvatar(_ imageData: Data) async throws -> URL? {
        let avatarResponse = try await profileManagerService.updateAvatar(imageData)
        return avatarResponse.photo
    }
}
