//
//  MapBackground.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct MapBackground: View {
    init() {
        self._coordinates = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    @ObservedObject var locationManager = LocationManager()
    var userLatitude: CLLocationDegrees {
        return locationManager.lastLocation?.coordinate.latitude ?? 48.7784485
    }

   var userLongitude: CLLocationDegrees {
        return locationManager.lastLocation?.coordinate.longitude ?? 9.1800132
   }
    @State var coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
 
        Map(coordinateRegion:  $coordinates).ignoresSafeArea()

    }
}

struct MapBackground_Previews: PreviewProvider {
    static var previews: some View {
        MapBackground()
    }
}
