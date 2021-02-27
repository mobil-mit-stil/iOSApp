//
//  DriverNavigationView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct DriverNavigationView: View {
    init() {
        destinationPl = MapData()
        destinationPl.loadPlaceMark()
    }
    @State private var directions: [MKRoute.Step] = []
    @State private var showDirections = false
    @ObservedObject var locationManager = LocationManager()
    @State var showingPlaceDetails = false
    @State private var reloadMap = false
    @ObservedObject var destinationPl:MapData
  @State private var currentLocation = CLLocationCoordinate2D()
  var body: some View {
    ZStack {
        MapView(directions: $directions, destination: $destinationPl.placeMark).ignoresSafeArea()
        VStack {

                ScrollView() {
                    ForEach(directions, id: \.self) { direction in
                        NavigationDirectionsView(direction: direction.instructions)
                    }
                }.frame(height: 200, alignment: .top)
                
            Spacer()
            PassengerGetToDriverInfoView(name: "Luca", eta: 4)
        }
    }.navigationBarHidden(true)
  }
    
    func getCurrentLocation() {

        let lat = locationManager.lastLocation?.coordinate.latitude ?? 0
        let log = locationManager.lastLocation?.coordinate.longitude ?? 0

        self.currentLocation.latitude = lat
        self.currentLocation.longitude = log

    }
    mutating func loadDestinationPlaceMark() {
        
        
    }
}
