//
//  LocationService.swift
//  Platform
//
//  Created by Александр Болотов on 05.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import CoreLocation
import RxCocoa
import RxSwift

public protocol LocationService {
    var locationObservable: Observable<CLLocation> { get }
    var authorizationStatusRealy: BehaviorRelay<CLAuthorizationStatus> { get }
    var locationEnabled: BehaviorRelay<Bool> { get }
    func requestAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestLocation()
}

final class LocationServiceImpl: NSObject, LocationService {
    // MARK: - Public properties
    
    var locationEnabled = BehaviorRelay<Bool>(value: false)

    var authorizationStatusRealy = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)

    var locationObservable: Observable<CLLocation> {
        locationSubject
            .asObservable()
    }

    // MARK: - Private properties

    private var locationManager = CLLocationManager()
    private let locationSubject = PublishSubject<CLLocation>()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: - Public meethods

    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 3
        locationManager.startUpdatingLocation()
    }

    /// а что будем делать если два консюмера будут следить за локацией, и один из них отменит апдейтинг. тогда у
    /// второго тоже отменится.
    /// но пока только один консюмер, можно забить
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationServiceImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatusRealy.accept(status)
        switch status {
        case .authorizedWhenInUse,
             .authorizedAlways:
            print("Доступ к геолокации предоставлен.")
            locationEnabled.accept(true)
        case .denied,
             .restricted:
            print("Доступ к геолокации запрещен.")
            locationEnabled.accept(false)
            locationManager.stopUpdatingLocation()
        case .notDetermined:
            print("Статус доступа не определен.")
            locationEnabled.accept(false)
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("Неизвестный статус авторизации: \(status)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {

            print("Новое местоположение: \(location.coordinate)")
            locationSubject.onNext(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка LocationManager: \(error.localizedDescription)")
    }
}
