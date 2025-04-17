//
//  WorkSheetManagerServiceTarget.swift
//  Platform
//
//  Created by Vladislav on 11.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

#if MOCK
    typealias WorkSheetManagerServiceTarget = WorkSheetManagerServiceTargetMock
#else
    typealias WorkSheetManagerServiceTarget = WorkSheetManagerServiceTargetApi
#endif

protocol WorkSheetManagerServiceTargetProtocol {
    static func getQuestionnaire() -> BallTarget
}

public enum WorkSheetManagerServiceTargetApi: WorkSheetManagerServiceTargetProtocol {
    public static func getQuestionnaire() -> BallTarget {
        BallTargetModel(
            path: "/api/account/questionnaire/",
            method: .get
        )
    }
}

public enum WorkSheetManagerServiceTargetMock: WorkSheetManagerServiceTargetProtocol {
    public static func getQuestionnaire() -> BallTarget {
        BallTargetModel(
            path: "/api/account/questionnaire/",
            method: .get
        )
    }
}
