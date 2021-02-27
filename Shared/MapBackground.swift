//
//  MapBackground.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct MapBackground: View {
    init(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        self._coordinates = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    @State var coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
 
        Map(coordinateRegion:  $coordinates).ignoresSafeArea()

    }
}

struct MapBackground_Previews: PreviewProvider {
    static var previews: some View {
        MapBackground(lat: 51.507222, lon: -0.1275)
    }
}
