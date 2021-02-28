//
//  types.swift
//  MobilMitStil
//
//  Created by Schimweg, Luca on 26/02/2021.
//

import Foundation

struct Location : Codable, Hashable, Equatable {
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

struct Confirmation : Codable {
    var passengerId: Uuid
    var accepted: Bool
}

struct PassengerRequest : Codable {
    var location: Location
    var destination: Location
    var tolerance: Int
    var requestedSeats: Int
    var preferences: RidePreferences
}

struct PassengerInformation : Codable, Hashable, Equatable {
   
    var driverId: Uuid
    var pickupTime: Int
    var destinationTime: Int
    var pickupPoint: Location
    var dropoffPoint: Location
   
}

struct SessionResponse : Codable {
    var sessionId: SessionId
}

struct PassengerBookRequest : Codable {
    var driverId: Uuid
}
struct names {
    static var name = "Dustin"
}
