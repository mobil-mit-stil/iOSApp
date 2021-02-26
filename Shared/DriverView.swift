//
//  DriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 26.02.21.
//

import SwiftUI
import MapKit

struct DriverView: View {
    
    init(name: String, eta: Int, latitude: CGFloat, longitude: CGFloat) {
        self._name = State(initialValue: name)
        self._eta = State(initialValue: eta)
        self._coordinates = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
    
    @State var name: String = ""
    @State var eta: Int = 0 // Estimated time of arrival
    @State var coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    @State var places = [Place(name: "Driver", latitude: 51.508052, longitude: -0.076035)]
    var body: some View {
        
        Button(action: {
            print("Edit tapped!")
        }) {
            VStack {
                Text(name)
                    .bold()
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.black)
                Text("The driver will be here in \(eta) minutes").foregroundColor(.black)
                Map(coordinateRegion: $coordinates, annotationItems: places) { place in
                    MapMarker(coordinate: place.coordinate)
                }
                .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.background(Color("BackgroundTop"))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 3, x: 3, y: 3)
           
        }
        
        
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView(name: "Dumme Sau", eta: 4, latitude: 51.507222, longitude: -0.1275)
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
