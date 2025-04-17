//
//  PushServiceTarget.swift
//  Platform
//
//  Created by Zart Arn on 09.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

enum PushServiceTarget {
    static func registerDevice(token: String) -> any BallTarget {
        let deviceInfo = getDeviceModel()
        return BallTargetModel(
            path: "api/fcm/devices/",
            method: .post,
            parameters: .requestParameters(
                parameters: [
                    "registration_id": token,
                    "type": "ios",
                    "device_id": deviceInfo,
                ]
            )
        )
    }
    
    static func unRegisterDevice(token: String) -> any BallTarget {
        let deviceInfo = getDeviceModel()
        return BallTargetModel(
            path: "api/fcm/devices/",
            method: .post,
            parameters: .requestParameters(
                parameters: [
                    "registration_id": token,
                    "type": "ios",
                    "device_id": deviceInfo,
                ]
            ),
            shouldAuthorize: false
        )
    }
}

extension PushServiceTarget {
    static func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafeBytes(of: systemInfo.machine) { rawBuffer in
            rawBuffer.split(separator: 0).compactMap { String(bytes: $0, encoding: .utf8) }.first ?? "Unknown"
        }
    }
}
