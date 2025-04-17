//
//  WorkSheetManagerService.swift
//  Platform
//
//  Created by Александр Болотов on 20.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//


public protocol WorkSheetManagerService {
    func getQuestionnaire() async throws -> QuestionnaireModel?
}
