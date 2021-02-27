//
//  ChooseDriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct ChooseDriverView: View {
    init() {
        
        
        
    }
    
    var drivers = [Driver(name: "Marc Jacob", eta: 19, latitude: 49.2939547, longitude: 8.6405714), Driver(name: "Duc Vo Nogc", eta: 13, latitude: 51.507222, longitude: -0.1275)]
    
    var body: some View {
       
        ZStack {
            ScrollView {
                VStack {
                    ForEach(drivers, id: \.self) { d in
                        DriverView(name: d.name, eta: d.eta, latitude: d.latitude, longitude: d.longitude).padding()
                    }
                    Text("Searching for drivers...").font(.largeTitle).padding(40)
                }
            }
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct ChooseDriverView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDriverView()
    }
}
struct Driver: Hashable {
    var name: String
    var eta: Int // estimated time of arrival
    var latitude: CGFloat
    var longitude: CGFloat
}
