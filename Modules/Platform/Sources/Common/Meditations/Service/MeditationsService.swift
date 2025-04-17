//
// MeditationsService.swift
//
// Copyright ©  Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol MeditationsService {
    func getMeditationsList() async throws -> MeditationList
    func getMeditation(with id: Int) async throws -> MeditationDetail
}
