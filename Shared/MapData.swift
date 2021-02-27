//
//  MapData.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import Foundation
import MapKit
import SwiftUI

class MapData: ObservableObject {
    static var shared = MapData()
    var placeMark: MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.29370900, longitude: 0.63844421))
    var passengerData = [PassengerInformation]()
    var timerChooseDriver: Timer?
    var runCounter = 0
    
    
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
                    
                    pasPostStart()
                    print("Destination is loaded")
                    first = false
                }
            }
        }
    }
    func pasPostStart() {
        let psgReq = PassengerRequest(location: Location(latitude: LocationManager().lastLocation?.coordinate.latitude ?? 0, longitude: LocationManager().lastLocation?.coordinate.longitude ?? 0), destination: Location(latitude: MapData.shared.placeMark.coordinate.latitude, longitude: MapData.shared.placeMark.coordinate.longitude), tolerance: 500, requestedSeats: 1, preferences: RidePreferences(smoker: true, children: false));
        
        DispatchQueue.global(qos: .utility).async {
            let result = PassengerApi.shared.postStart(config: psgReq)
            DispatchQueue.main.async { [self] in
                print(result)
                switch result {
                case let .success(data):
                    print("TheData")
                    print(data);
                    timerChooseDriver = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pasGetInfo), userInfo: nil, repeats: true)
                case let .failure(error):
                    print(error);
                }
            }
            
        }
    }
    @objc func pasGetInfo() {
        runCounter += 1
        if runCounter > 80 {
            timerChooseDriver?.invalidate()
        }
        DispatchQueue.global(qos: .utility).async {
            let result = PassengerApi.shared.getInformation()
            DispatchQueue.main.async { [self] in
                print("...........")
                print(result)
                switch result {
                
                case let .success(data):
                    print("PassenerData")
                    print(data);
                    passengerData = data
                    
                case let .failure(error):
                    passengerData = [PassengerInformation]()
                    print(error);
                }
            }
            
        }
    }
}
