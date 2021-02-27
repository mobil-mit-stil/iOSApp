//
//  types.swift
//  MobilMitStil
//
//  Created by Schimweg, Luca on 26/02/2021.
//

import Foundation

struct Location : Codable {
    var latitude: Double
    var longitude: Double
}

struct RidePreferences : Codable {
    var smoker: Bool
    var children: Bool
}

struct RideConfig : Codable {
    var locations: [Location]
    var seats: Int
    var preferences: RidePreferences
}

typealias SessionId = String;

typealias Uuid = String;

struct DriverInformation : Codable {
    var passengerId: Uuid
    var pickupPoint: Location
    var dropoffPoint: Location
    var requested: Bool
}

struct Estimation : Codable {
    var passengerId: Uuid
    var pickupTime: Int
    var destinationTime: Int
}

typealias AcceptanceStatus = String;

struct Confirmation : Codable {
    var passengerId: Uuid
    var status: AcceptanceStatus
}


struct PassengerRequest : Codable {
    var location: Location
    var destination: Location
    var tolerance: Int
    var requestedSeats: Int
    var preferences: RidePreferences
}

struct PassengerInformation : Codable, Hashable {
    var driverId: Uuid
    var pickupTime: Int
    var destinationTime: Int
}

struct SessionResponse : Codable {
    var sessionId: SessionId
}

struct PassengerBookRequest : Codable {
    var driverId: Uuid
}
