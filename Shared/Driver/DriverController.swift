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
    
    init(mapDisplayData: MapDisplayData) {
        self.mapDisplayData = mapDisplayData
    }
}

class DriverController {
    var data: DriverData
    var mapDisplayController: MapDisplayController
    var api = DriverApi()
    var seats: Int = 1
    
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
    }
}
