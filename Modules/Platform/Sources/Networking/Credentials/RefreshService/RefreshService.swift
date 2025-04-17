//
//  RefreshService.swift
//  Platform
//
//  Created by Zart Arn on 30.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

protocol RefreshService {
    func refreshToken(_ token: String) async throws -> Token
}
