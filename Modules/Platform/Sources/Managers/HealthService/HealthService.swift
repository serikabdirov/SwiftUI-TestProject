//
//  HealthService.swift
//  Platform
//
//  Created by Александр Болотов on 02.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import CoreLocation
import HealthKit
import RxRelay
import RxSwift

public protocol HealthService {
    var isAuthorizedRelay: BehaviorRelay<Bool> { get }
    var authorizationRequestStatus: HKAuthorizationRequestStatus { get }
    func requestAuthorization()
    func checkAuthorizationStatus()
    
    /// User characteristics
    func getUserWeight() async throws -> Double?

    /// Running workout methods
    func startRunningWorkout()
    func finishRunningWorkout()
    func pauseRunningWorkout()
    func resumeRunningWorkout()
    func insertRouteRunningWorkout(location: CLLocation)
    func addPace(secondsPerKilometer: Double, start: Date, end: Date) async throws
    func addCaloriesBurned(_ calories: Double, start: Date, end: Date) async throws
    func addDistance(_ meters: Double, start: Date, end: Date) async throws
}

public final class HealthServiceImpl: HealthService {
    // MARK: - Public properties

    public var isAuthorizedRelay = BehaviorRelay<Bool>(value: false)
    public var authorizationRequestStatus = HKAuthorizationRequestStatus.shouldRequest

    // MARK: - Private properties

    private let healthStore = HKHealthStore()
    private var startDate: Date?
    private var workoutBuilder: HKWorkoutBuilder?
    private var workoutRouteBuilder: HKWorkoutRouteBuilder?

    private lazy var healthKitIsAvailable: Bool = HKHealthStore.isHealthDataAvailable()

    private let readTypes: Set<HKObjectType> = [
        HKQuantityType(.distanceWalkingRunning),
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.bodyMass),
        HKWorkoutType.workoutType(),
        HKSeriesType.workoutRoute(),

        HKCharacteristicType(.dateOfBirth),
    ]

    private let shareTypes: Set<HKSampleType> = [
        HKQuantityType(.distanceWalkingRunning),
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.bodyMass),
        HKWorkoutType.workoutType(),
        HKSeriesType.workoutRoute(),
    ]

    // MARK: - Init

    init() {
        checkAuthorizationStatus()
    }
}

// MARK: - Authorization methods

public extension HealthServiceImpl {
    func checkAuthorizationStatus() {
        guard healthKitIsAvailable else { return }

        let distanceWalkingRunningStatus = healthStore
            .authorizationStatus(for: HKQuantityType(.distanceWalkingRunning)) == .sharingAuthorized
        let activeEnergyBurnedStatus = healthStore
            .authorizationStatus(for: HKQuantityType(.activeEnergyBurned)) == .sharingAuthorized
        let bodyMassStatus = healthStore.authorizationStatus(for: HKQuantityType(.bodyMass)) == .sharingAuthorized
        let workoutTypeStatus = healthStore.authorizationStatus(for: HKWorkoutType.workoutType()) == .sharingAuthorized
        let workoutRouteStatus = healthStore.authorizationStatus(for: HKSeriesType.workoutRoute()) == .sharingAuthorized

        isAuthorizedRelay
            .accept(
                distanceWalkingRunningStatus && activeEnergyBurnedStatus && bodyMassStatus && workoutTypeStatus &&
                    workoutRouteStatus
            )

        Task {
            authorizationRequestStatus = try await healthStore.statusForAuthorizationRequest(
                toShare: shareTypes,
                read: readTypes
            )
        }
    }

    func requestAuthorization() {
        guard healthKitIsAvailable else { return }

        Task {
            try await healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
            checkAuthorizationStatus()
        }
    }
}

// MARK: User data

public extension HealthServiceImpl {
    func getUserWeight() async throws -> Double? {
        guard healthKitIsAvailable else { return nil }

        guard let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            return nil
        }

        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(type: weightType)],
            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
            limit: 1
        )

        let result = try await descriptor.result(for: healthStore)
        
        return result.first?.quantity.doubleValue(for: HKUnit(from: .kilogram))
    }
}

// MARK: Workout methods

public extension HealthServiceImpl {
    func startRunningWorkout() {
        Task {
            let configuration = HKWorkoutConfiguration()
            configuration.activityType = .running
            configuration.locationType = .outdoor
            workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: configuration, device: .local())
            try await workoutBuilder?.beginCollection(at: .now)
            workoutRouteBuilder = HKWorkoutRouteBuilder(healthStore: healthStore, device: .local())
        }
    }

    func finishRunningWorkout() {
        Task {
            do {
                try await workoutBuilder?.endCollection(at: .now)
                if let workout = try await workoutBuilder?.finishWorkout() {
                    try await workoutRouteBuilder?.finishRoute(with: workout, metadata: nil)
                }
            } catch {
                debugPrint("Ошибка записи тренировки: \(error.localizedDescription)")
            }
        }
    }

    func pauseRunningWorkout() {
        Task {
            try await workoutBuilder?.addWorkoutEvents(
                [HKWorkoutEvent(
                    type: .pause,
                    dateInterval: .init(),
                    metadata: nil
                )]
            )
        }
    }

    func resumeRunningWorkout() {
        Task {
            try await workoutBuilder?.addWorkoutEvents(
                [HKWorkoutEvent(
                    type: .resume,
                    dateInterval: .init(),
                    metadata: nil
                )]
            )
        }
    }

    func insertRouteRunningWorkout(location: CLLocation) {
        Task {
            try await workoutRouteBuilder?.insertRouteData([location])
        }
    }

    func addCaloriesBurned(_ calories: Double, start: Date, end: Date) async throws {
        let calorieType = HKQuantityType(.activeEnergyBurned)
        let calorieQuantity = HKQuantity(unit: .kilocalorie(), doubleValue: calories)
        let calorieSample = HKQuantitySample(
            type: calorieType,
            quantity: calorieQuantity,
            start: start,
            end: end
        )

        try await workoutBuilder?.addSamples([calorieSample])
    }

    func addPace(secondsPerKilometer: Double, start: Date, end: Date) async throws {
        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second()) // Конвертируем темп в скорость
        let speedValue = 1000 / secondsPerKilometer // м/с

        let paceType = HKQuantityType(.runningSpeed)
        let paceQuantity = HKQuantity(unit: speedUnit, doubleValue: speedValue)
        let paceSample = HKQuantitySample(
            type: paceType,
            quantity: paceQuantity,
            start: start,
            end: end
        )

        try await workoutBuilder?.addSamples([paceSample])
    }

    func addDistance(_ meters: Double, start: Date, end: Date) async throws {
        let distanceType = HKQuantityType(.distanceWalkingRunning)
        let distanceQuantity = HKQuantity(unit: .meter(), doubleValue: meters)

        let distanceSample = HKQuantitySample(
            type: distanceType,
            quantity: distanceQuantity,
            start: start,
            end: end
        )

        try await workoutBuilder?.addSamples([distanceSample])
    }
}
