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
    var controller: PassengerController
    @ObservedObject var data: PassengerData
    
    init(controller: PassengerController) {
        self.controller = controller
        data = controller.data
    }
    
    var body: some View {
       
        ZStack {
            ScrollView {
                VStack {
                    ForEach(data.drivers, id: \.self) { d in
                        DriverView(driver: d, controller: controller).padding()
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
        ChooseDriverView(controller: PassengerController())
    }
}
struct Driver: Hashable {
    var name: String
    var eta: Int // estimated time of arrival
    var latitude: CGFloat
    var longitude: CGFloat
}
