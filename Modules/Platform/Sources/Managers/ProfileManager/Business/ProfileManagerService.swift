//
//  ProfileManagerService.swift
//  Platform
//
//  Created by Евграфов Максим on 12.11.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol ProfileManagerService {
    func logout() async throws -> Void
    func getProfile() async throws -> Profile
    func updateProfile(with parameters: ProfilePatchData) async throws -> Profile
    func updateAvatar(_ imageData: Data) async throws -> AvatarResponse
    func deleteProfile() async throws
}
