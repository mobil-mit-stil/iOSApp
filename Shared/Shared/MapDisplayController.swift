//
//  MapData.swift
//  MobilMitStil (iOS)
//
//  Created by Michael Spilger on 27.02.21.
//

import Foundation
import MapKit
import SwiftUI

class MapDisplayData : ObservableObject {
    var locationManager = LocationManager();
    var currentLocation = CLLocationCoordinate2D();
    var destination = CLLocationCoordinate2D();
    var route: MKRoute?;
    var directions: [MKRoute.Step]?
    
    @Published var loaded = false;
    
    init() { }
    
    func getRouteLocations() -> [Location] {
        var locations: [Location] = []
        
        for step in route!.steps {
            locations.append(step.polyline.coordinate.toModel())
        }
        
        return locations
    }
}

class MapDisplayController {
    var data: MapDisplayData
    
    init() {
        print("INIT")
        data = MapDisplayData()
    }
    
    func fillDestination(to: String) {
        let placemark = loadPlaceMark(destination: to)
        self.data.destination = placemark!.location!.coordinate;
    }
    
    func loadPlaceMark(destination: String) -> MKPlacemark? {
        let semaphore = DispatchSemaphore(value: 0)
        
        var placemark: MKPlacemark?
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = destination
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                print("Error:( \(error?.localizedDescription ?? "Unknown error").")
                semaphore.signal()
                return
            }
            for item in response.mapItems {
                placemark = item.placemark
                semaphore.signal()
                return
            }
            semaphore.signal()
        }
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return placemark
    }
    
    func updateCurrentLocation() {
        let lat = data.locationManager.lastLocation?.coordinate.latitude ?? 0
        let log = data.locationManager.lastLocation?.coordinate.longitude ?? 0
        
        data.currentLocation.latitude = lat
        data.currentLocation.longitude = log
    }
    
    func calculateRoute() {
        let request = MKDirections.Request()
        self.updateCurrentLocation()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: data.currentLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: data.destination))
        request.transportType = .automobile
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            self.data.route = response?.routes.first
            semaphore.signal()
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
        DispatchQueue.main.async { [self] in
            data.loaded = true
        }
    }
    
    
    func someAuthorization() {
//        let status = CLLocationManager.authorizationStatus()
//        data.locationManager.requestAlwaysAuthorization()
//        data.locationManager.requestWhenInUseAuthorization()
//
//        if status == .authorizedAlways || status == .authorizedWhenInUse {
//            data.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            data.locationManager.startUpdatingLocation()
//            let location: CLLocationCoordinate2D = data.locationManager.location!.coordinate
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: location, span: span)
//            view.setRegion(region, animated: true)
//        }
    }
}
