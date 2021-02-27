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

    var placeMark: MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.29370900, longitude: 0.63844421))
    
    func loadPlaceMark() {
        let destination = UserDefaults.standard.string(forKey: "destination")
        print("HALLOOO")
        print(destination ?? ":(")
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
                    print("TOGGLEEE")
                    first = false
                }
            }
        }
    }
}
