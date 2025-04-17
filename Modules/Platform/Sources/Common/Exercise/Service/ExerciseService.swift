//
// ExerciseService.swift
//
// Copyright ©  Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol ExerciseService {
    func getTrainigsList(actual: Bool) async throws -> TrainigsList
    func getTrainingDetail(id: Int) async throws -> TrainingDetail

    func trainigRecord(model: any RecordModel) async throws -> TrainingDetail
    func finishTraining(recordId: Int, report: TrainingReport) async throws -> TrainingDetail

    func postSchedule(id: Int, scheduleList: ScheduleList, until: Date?) async throws
}

public extension ExerciseService {
    func getTrainigsList() async throws -> TrainigsList {
        try await getTrainigsList(actual: false)
    }
}
