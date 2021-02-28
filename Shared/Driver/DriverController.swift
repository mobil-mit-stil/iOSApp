//
//  DriverController.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import Foundation
import MapKit
import SwiftUI

enum MapError : Error {
    case calculation
}

class DriverData : ObservableObject {
    @ObservedObject var mapDisplayData: MapDisplayData
    var requests: [DriverInformation] = []
    
    init(mapDisplayData: MapDisplayData) {
        self.mapDisplayData = mapDisplayData
    }
}

class DriverController {
    var data: DriverData
    var mapDisplayController: MapDisplayController
    var api = DriverApi()
    var seats: Int = 1
    var loopRunning = true
    
    init() {
        mapDisplayController = MapDisplayController()
        data = DriverData(mapDisplayData: mapDisplayController.data)
    }
    
    public func postStartDriving() {
        print("CREATNG ROUTE ON SERVER")
        let locations = mapDisplayController.data.getRouteLocations()
        print(locations)
        print("CURRENTLY AT:")
        print(mapDisplayController.data.currentLocation)
        print("SEATS: ", seats)
        let res = self.api.startDrive(config: RideConfig(locations: locations, seats: seats, preferences: RidePreferences(smoker: true, children: false)))
        DispatchQueue.main.async {
            switch res {
            case .success(_):
                return
            case let .failure(error):
                print(error);
            }
        }
        
        startUpdateLoop()
    }
    
    public func getInformation() {
        let res = self.api.getInformation()
        DispatchQueue.main.async {
            switch res {
            case let .success(riders):
                self.data.requests = riders.filter { $0.requested }
                return
            case let .failure(error):
                print(error);
            }
        }
    }
    
    public func startUpdateLoop() {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now(), repeating: .seconds(2))
        t.setEventHandler(handler: { [self] in
            print("hi")
            if !loopRunning {
                t.cancel()
            }
            getInformation()
            
        })
        t.resume()
    
    }
    
    public func accept(passenger: DriverInformation) {
        data.requests.removeAll {$0.passengerId == passenger.passengerId}
        print("CREATNG ROUTE ON SERVER")
        let locations = mapDisplayController.data.getRouteLocations()
        print(locations)
        print("CURRENTLY AT:")
        print(mapDisplayController.data.currentLocation)
        print("SEATS: ", seats)
        let res = self.api.postConfirmations(confirmations: [Confirmation(passengerId: passenger.passengerId, accepted: true)])
        DispatchQueue.main.async {
            switch res {
            case .success(_):
                self.mapDisplayController.data.stops.append(MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: passenger.dropoffPoint.latitude, longitude: passenger.dropoffPoint.longitude)))
                
                self.mapDisplayController.data.stops.append(MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: passenger.pickupPoint.latitude + 0.1, longitude: passenger.pickupPoint.longitude)))
                return
            case let .failure(error):
                print(error);
            }
        }

    }
    
    public func decline(passenger: DriverInformation) {
        print("CREATNG ROUTE ON SERVER")
        let locations = mapDisplayController.data.getRouteLocations()
        print(locations)
        print("CURRENTLY AT:")
        print(mapDisplayController.data.currentLocation)
        print("SEATS: ", seats)
        let res = self.api.postConfirmations(confirmations: [Confirmation(passengerId: passenger.passengerId, accepted: false)])
        DispatchQueue.main.async {
            switch res {
            case .success(_):
                return
            case let .failure(error):
                print(error);
            }
        }
    }
}
