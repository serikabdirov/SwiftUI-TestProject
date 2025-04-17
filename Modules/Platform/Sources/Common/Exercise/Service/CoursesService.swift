//
// CoursesService.swift
//
// Copyright ©  Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public protocol CoursesService {
    func getCoursesList() async throws -> CoursesList
    func getCourseDetail(id: Int) async throws -> CourseDetail

    func getSchedule(recordId: Int) async throws -> ScheduleList

    func postSchedule(recordId: Int, scheduleList: ScheduleList) async throws -> ScheduleList

    func startCourse(id: Int, scheduleList: ScheduleList) async throws -> CourseDetail

    func finishCourse(recordId: Int) async throws -> CourseDetail
}
