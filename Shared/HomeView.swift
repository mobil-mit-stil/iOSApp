//
//  HomeView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @State var coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $coordinates).ignoresSafeArea()
            ZStack {
                VStack(alignment: .trailing) {
                    WhereToGo().padding()
                    //DriverView(name: "Dumme Sau", eta: 4, latitude: 51.507222, longitude: -0.1275).padding()
                }
            }
            
            
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
