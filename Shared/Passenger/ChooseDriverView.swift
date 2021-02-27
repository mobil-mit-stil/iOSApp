//
//  ChooseDriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit
import Alamofire

struct ChooseDriverView: View {
    init() {
        self.apiData = MapData.shared
    }
    @ObservedObject var apiData: MapData
    var locationManager = LocationManager()
    var drivers = [Driver(name: "Marc Jacob", eta: 19, latitude: 49.2939547, longitude: 8.6405714)]
    
    var body: some View {
       
        ZStack {
            ScrollView {
                VStack {
                    ForEach(apiData.passengerData, id: \.self) { d in
                        DriverView(pickupTime: d.pickupTime, destinationTime: d.destinationTime).padding()
                    }
                    Text("Searching for drivers...").font(.largeTitle).padding(40)
                }
            }
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .frame(width: UIScreen.screenWidth*1.5)
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
