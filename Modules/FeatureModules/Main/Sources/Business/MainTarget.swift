//
//  MainTarget.swift
//  Main
//
//  Created by Серик Абдиров on 06.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import Platform
import R

#if MOCK
    typealias MainTarget = MainTargetMock
#else
    typealias MainTarget = MainTargetApi
#endif

protocol MainTargetProtocol {
    static func getData() -> any BallTarget
}

enum MainTargetApi: MainTargetProtocol {
    static func getData() -> any BallTarget {
        BallTargetModel(path: "")
    }
}

enum MainTargetMock: MainTargetProtocol {
    static func getData() -> any BallTarget {
        BallTargetModel(path: R.Files.Modules.R.Resources.Mock.mainGetDataJson.path)
    }
}
