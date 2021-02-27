//
//  DriverObservable.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import Foundation


import Foundation
import MapKit
import SwiftUI

class DriverObservable: ObservableObject {
    static var shared = DriverObservable()
    var placeMark: MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.29370900, longitude: 0.63844421)) // UserLocation
    var driverData = [DriverInformation]() // Who to pick up
    var timerChooseDriver: Timer?
    var runCounter = 0
    
    
    
    func loadPlaceMark() {
        let destination = UserDefaults.standard.string(forKey: "destination")
        //print("HALLOOO")
        //print(destination ?? ":(")
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = destination
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] response, error in
            guard let response = response else {
                print("Error:( \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            var first = true
            for item in response.mapItems {
                if first {
                    placeMark = item.placemark
                    print("Destination is loaded")
                    first = false
                }
            }
        }
        
    }
    func loadPlaceMarcPassenger() {
        let destination = UserDefaults.standard.string(forKey: "destination")
        //print("HALLOOO")
        //print(destination ?? ":(")
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = destination
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] response, error in
            guard let response = response else {
                print("Error:( \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            var first = true
            for item in response.mapItems {
                if first {
                    placeMark = item.placemark
                    
                    driverPostStart()
                    print("Destination is loaded")
                    first = false
                }
            }
        }
    }
    func driverPostStart() {
        let psgReq = RideConfig(locations: [Location(latitude: LocationManager().lastLocation?.coordinate.latitude ?? 0, longitude: LocationManager().lastLocation?.coordinate.longitude ?? 0), Location(latitude: MapData.shared.placeMark.coordinate.latitude, longitude: MapData.shared.placeMark.coordinate.longitude)], seats: UserDefaults.standard.integer(forKey: "freeSeats"), preferences: RidePreferences(smoker: true, children: false))
            //PassengerRequest(location: Location(latitude: LocationManager().lastLocation?.coordinate.latitude ?? 0, longitude: LocationManager().lastLocation?.coordinate.longitude ?? 0), destination: Location(latitude: MapData.shared.placeMark.coordinate.latitude, longitude: MapData.shared.placeMark.coordinate.longitude), tolerance: 500, requestedSeats: 1, preferences: RidePreferences(smoker: true, children: false));
        
        DispatchQueue.global(qos: .utility).async {
            let result = DriverApi.shared.startDrive(config: psgReq)
            DispatchQueue.main.async { [self] in
                print(result)
                switch result {
                case let .success(data):
                    print("TheData")
                    print(data);
                    //timerChooseDriver = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pasGetInfo), userInfo: nil, repeats: true)
                case let .failure(error):
                    print(error);
                }
            }
            
        }
    }
    @objc func pasGetInfo() {
        DispatchQueue.global(qos: .utility).async {
            let result = DriverApi.shared.getInformation()
            DispatchQueue.main.async { [self] in
                print("...........")
                print(result)
                switch result {
                
                case let .success(data):
                    print("DriverData")
                    print(data);
                    driverData = data
                    
                case let .failure(error):
                    driverData = [DriverInformation]()
                    print(error);
                }
            }
            
        }
    }
    
    @objc func sendDriveInfo() {
    
    }
}
