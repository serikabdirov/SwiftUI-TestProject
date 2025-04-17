//
//  Stopwatch.swift
//  Core
//
//  Created by Александр Болотов on 18.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public final class Stopwatch {
    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let timerSubject = BehaviorSubject<TimeInterval>(value: 0)
    private var startTime: Date?
    private var elapsedTime: TimeInterval = 0
    private var isPaused = false
    private var timerDisposable: Disposable?

    // MARK: - Public properties

    public var onTick: Observable<TimeInterval> {
        timerSubject.asObservable()
    }

    // MARK: - Init

    public init() {}

    // MARK: - Public methods

    public func start() {
        guard timerDisposable == nil else { return }
        elapsedTime = 0
        timerSubject.onNext(0)
        startTime = Date().addingTimeInterval(-elapsedTime)
        scheduleTimer()
    }

    public func pause() {
        guard !isPaused, timerDisposable != nil else { return }
        isPaused = true
        elapsedTime = Date().timeIntervalSince(startTime ?? Date())
        timerDisposable?.dispose()
        timerDisposable = nil
    }

    public func resume() {
        guard isPaused else { return }
        isPaused = false
        startTime = Date().addingTimeInterval(-elapsedTime)
        scheduleTimer()
    }

    public func stop() {
        timerDisposable?.dispose()
        timerDisposable = nil
        isPaused = false
    }

    // MARK: - Private methods

    private func scheduleTimer() {
        timerDisposable = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self, let startTime = self.startTime else { return }
                let elapsed = Date().timeIntervalSince(startTime)
                self.timerSubject.onNext(elapsed)
            })
        timerDisposable?.disposed(by: disposeBag)
    }
}
