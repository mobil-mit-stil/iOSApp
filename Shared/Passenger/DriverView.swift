//
//  DriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 26.02.21.
//

import SwiftUI
import MapKit

struct DriverView: View {
    
    var driver: PassengerInformation
    var controller: PassengerController
    
    init(driver: PassengerInformation, controller: PassengerController) {
        self.controller = controller
        self.driver = driver
        self._name = State(wrappedValue: driver.pickupTime)
        self._eta = State(wrappedValue: driver.destinationTime)
        self._coordinates = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(51.507222), longitude: CLLocationDegrees(-0.1275)), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
    
    @State var name: Int = 0
    @State var eta: Int = 0 // Estimated time of arrival
    @State var coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State var places = [Place(name: "Driver", latitude: 51.507222, longitude: 1275)]
    var body: some View {
        
        NavigationLink(destination: PassengerGetToDriverView(controller: controller)) {
            VStack {
                Text("\(name) minutes until the driver arrives at the pick up point!")
                    .bold()
                    .font(.title2)
                    .padding()
                    .foregroundColor(.black)
                Text("The ride with this driver will take \(eta) minutes").foregroundColor(.black)
                Map(coordinateRegion: $coordinates, annotationItems: places) { place in
                    MapMarker(coordinate: place.coordinate)
                }.disabled(true)
                .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.background(Color("BackgroundTop"))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 3, x: 3, y: 3)
           
        }.simultaneousGesture(TapGesture().onEnded {
            controller.requestAndWaitForApproval(driver: driver)
        })
        
        
    }
}


struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
