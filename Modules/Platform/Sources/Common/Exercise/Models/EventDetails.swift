//
//  EventDetails.swift
//  Platform
//
//  Created by Vladislav on 25.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import BetterCodable
import CoreLocation

public struct EventDetail: Codable {
    public let id: Int
    let eventType: EventType
    public let name: String
    @DateValue<ISO8601Strategy>
    public var startDate: Date
    @DateValue<ISO8601Strategy>
    public var endDate: Date
    public let cover: String
    public let status: EventStatus
    public let multiplier: Multiplier
    public let ratingAwardPoints: Int
    public let hashtag: String
    public let country: Country
    let awardStatus: AwardStatus
    public let description: String?
    public let executionConditions: String?
    public let location: Location?
    public let photoExample: String?
    public let summingUpData: SummingUpData?
    public let eventRecord: EventRecord?
    
    enum EventType: String, Codable {
        case placeVisiting = "place_visiting"
        case performingActions = "performing_actions"
    }
    
    public enum EventStatus: String, Codable {
        case notStarted = "not_started"
        case inProgress = "in_progress"
        case completed
    }
    
    enum AwardStatus: String, Codable {
        case resultsNotSummedUp = "results_not_summed_up"
        case prizePlace = "prize_place"
        case notOnWinnersList = "not_on_winners_list"
    }
    
    public struct Multiplier: Codable {
        public let name: String
        let value: Double
        let duration: String
    }
    
    public struct Country: Codable {
        let id: Int
        public let name: String
    }
    
    public struct Location: Codable {
        public let longitude: Double?
        public let latitude: Double?
    }
    
    public struct SummingUpData: Codable {
        public let participantsNumber: Int?
        let summingUpDate: String?
    }
    
    public struct EventRecord: Codable {
        public let id: String
        let location: Location?
        public let photoResult: String?
    }
}

// MARK: - EventDetail Extension for Address
public extension EventDetail {
    func fetchAddress(completion: @escaping (String?) -> Void) {
        guard let latitude = location?.latitude, let longitude = location?.longitude else {
            completion(nil)
            return
        }
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? placemark.administrativeArea ?? ""
                let street = placemark.thoroughfare ?? ""
                let houseNumber = placemark.subThoroughfare ?? ""

                let formattedAddress = [city, street, houseNumber]
                    .filter { !$0.isEmpty }
                    .joined(separator: ", ")

                completion(formattedAddress.isEmpty ? nil : formattedAddress)
            } else {
                completion(nil)
            }
        }
    }
}
