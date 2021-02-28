//
//  DriverNavigationView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct DriverNavigationView: View {
    init(controller: DriverController) {
        destinationPl = MapData()
        //destinationPl.loadPlaceMark()
        self.controller = controller
        self.data = controller.data
        self.mapDisplayData = controller.data.mapDisplayData
    }
    
    @State private var directions: [MKRoute.Step] = []
    @State private var showDirections = false
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var destinationPl: MapData
    @State private var currentLocation = CLLocationCoordinate2D()
    
    @ObservedObject var data: DriverData;
    @ObservedObject var mapDisplayData: MapDisplayData
    
    var controller: DriverController;
    
    var body: some View {
        if mapDisplayData.loaded {
            ZStack {
                MapView(data: mapDisplayData).ignoresSafeArea()
                VStack {
                    
                    ScrollView() {
                        ForEach(directions, id: \.self) { direction in
                            NavigationDirectionsView(direction: direction.instructions)
                        }
                    }.frame(height: 200, alignment: .top)
                    if data.requests.count > 0 {
                        Spacer()
                        PassengerRequestView(controller: controller, passenger: data.requests[0])
                    }
                }
            }.navigationBarHidden(true)
        } else {
            Text("Loading...")
        }
       
    }

    mutating func loadDestinationPlaceMark() {
        
        
    }
}
