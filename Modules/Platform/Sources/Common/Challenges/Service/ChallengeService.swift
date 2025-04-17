//
// ChallengeService.swift
//
// Copyright ©  Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol ChallengeService {
    func getCoursesList() async throws -> CoursesList
    func getCovers() async throws -> [ChallengeCover]
    func getTrainigsList() async throws -> TrainigsList
    func getChallenges() async throws -> ChallengeList
}
