//
//  api:types.swift
//  MobilMitStil
//
//  Created by Schimweg, Luca on 26/02/2021.
//

import Foundation

struct Location {
    var latitude: Double
    var longitude: Double
}

struct RidePreferences {
    var smoker: Bool
    var children: Bool
}

struct RideConfig {
    var location: Location
    var seats: Int
    var preferences: RidePreferences
}

typealias SessionId = String;

typealias Uuid = String;

struct DriverInformation {
    var passengerId: Uuid
    var pickupPoint: Location
    var dropoffPoint: Location
    var requested: Bool
}

struct Estimation {
    var passengerId: Uuid
    var pickupTime: Int
    var destinationTime: Int
}

enum AcceptanceStatus {
    case ACCEPTED
    case DECLINED
}

struct Confirmation {
    passengerId: Uuid
    status: AcceptanceStatus
}


struct PassengerRequest {
    var location: Location
    var destination: Location
    var tolerance: Int
    var requestedSeats: Int
    var preferences: RidePreferences
}
