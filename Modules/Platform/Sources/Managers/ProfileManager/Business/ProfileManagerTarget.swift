//
//  ProfileManagerTarget.swift
//  Platform
//
//  Created by Евграфов Максим on 12.11.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//
import Foundation
import R

#if MOCK
    typealias ProfileManagerTarget = ProfileManagerTargetMock
#else
    typealias ProfileManagerTarget = ProfileManagerTargetApi
#endif

protocol ProfileManagerTargetProtocol {
    static func logOut() -> BallTarget
    static func updateAvatar(_ imageData: Data) -> BallTarget
    static func deleteProfile() -> BallTarget
}

// MARK: - Api Target

enum ProfileManagerTargetApi: ProfileManagerTargetProtocol {
    static func logOut() -> BallTarget {
        BallTargetModel(
            path: "/api/auth/logout/",
            method: .delete
        )
    }

    static func getProfile() -> BallTarget {
        BallTargetModel(
            path: "/api/account/profile/",
            method: .get
        )
    }

    static func patchProfile(with parameters: ProfilePatchData) -> BallTarget {
        BallTargetModel(
            path: "/api/account/profile/",
            method: .patch, // или .put — в зависимости от требований бэка
            parameters: .requestJSONEncodable(parameters),
            shouldAuthorize: true // чтобы был в заголовках токен
        )
    }

    static func updateAvatar(_ imageData: Data) -> BallTarget {
        BallTargetModel(
            path: "/api/account/profile/avatar/",
            method: .put,
            shouldAuthorize: true
        ) { data in
            data.append(imageData, withName: "photo", fileName: "image.jpg", mimeType: "image/jpg")
        }
    }

    static func deleteProfile() -> BallTarget {
        BallTargetModel(
            path: "/api/account/profile/",
            method: .delete
        )
    }
}

// MARK: Mock Target

enum ProfileManagerTargetMock: ProfileManagerTargetProtocol {
    
    static func logOut() -> BallTarget {
        BallTargetModel(path: "")
    }

    static func getProfile() -> BallTarget {
        BallTargetModel(path: "")
    }
    
    static func patchProfile(with parameters: ProfilePatchData) -> BallTarget {
        BallTargetModel(path: "")
    }

    static func updateAvatar(_ imageData: Data) -> BallTarget {
        BallTargetModel(path: "")
    }

    static func deleteProfile() -> BallTarget {
        BallTargetModel(path: "")
    }
}
