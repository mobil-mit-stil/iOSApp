//
//  PassengerController.swift
//  MobilMitStil (iOS)
//
//  Created by Michael Spilger on 27.02.21.
//

import Foundation
import MapKit

enum DriverAcceptanceStatus {
    case pending
    case accepted
    case declined
}

class PassengerData : ObservableObject {
    var locationManager = LocationManager()
    @Published var drivers: [PassengerInformation] = []
    var mapDisplayData: MapDisplayData
    @Published var driverAcceptanceStatus: DriverAcceptanceStatus = .pending
    
    init(data: MapDisplayData) {
        mapDisplayData = data
    }
}

class PassengerController {
    var mapDisplayController: MapDisplayController
    var data: PassengerData
    var api = PassengerApi()
    var loopRunning = true
    
    init() {
        mapDisplayController = MapDisplayController()
        data = PassengerData(data: mapDisplayController.data)
    }
    
    public func postStartPassenger() {
        print("CREATNG PASSENGER ON SERVER")
        print("CURRENTLY AT:")
        print(mapDisplayController.data.currentLocation)
        let res = self.api.postStart(config: PassengerRequest(location: mapDisplayController.data.currentLocation.toModel(), destination: mapDisplayController.data.destination.toModel(), tolerance: 1000, requestedSeats: 1, preferences: RidePreferences(smoker: true, children: false)))
        DispatchQueue.main.async {
            switch res {
            case .success(_):
                print("LIT MICH GIBTS JUNGE")
                return
            case let .failure(error):
                print(error);
            }
        }
        startUpdateLoop()
    }
    
    private func updateDrivers() {
        let res = self.api.getInformation()
        DispatchQueue.main.async {
            switch res {
            case let .success(drivers):
                self.data.drivers = drivers
                print(drivers)
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
            
            updateDrivers()
        })
        t.resume()
    
    }
    
    public func requestAndWaitForApproval(driver: PassengerInformation) {
        data.driverAcceptanceStatus = .pending
        DispatchQueue.global(qos: .background).async {
            let res = self.api.postRequest(driverId: driver.driverId)
            DispatchQueue.main.async {
                switch res {
                case .success(_):
                    print("Driver accepted us!")
                    self.data.mapDisplayData.currentLocation = self.data.locationManager.lastLocation!.coordinate;
                    self.data.mapDisplayData.destination = CLLocationCoordinate2D(latitude: self.data.drivers[0].pickupPoint.latitude, longitude: self.data.drivers[0].pickupPoint.longitude)
                    
                    //self.mapDisplayController.calculateRoute()
                    print(self.data.mapDisplayData.currentLocation)
                    self.data.driverAcceptanceStatus = .accepted
                    return
                case let .failure(error):
                    print(error);
                    self.data.driverAcceptanceStatus = .declined
                }
            }
            
        }
    }
}
