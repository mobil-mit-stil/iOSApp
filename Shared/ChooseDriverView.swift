//
//  ChooseDriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI

struct ChooseDriverView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    DriverView(name: "Marc Jacob", eta: 19, latitude: 49.2939547, longitude: 8.6405714).padding()
                    DriverView(name: "Duc Vo Nogc", eta: 13, latitude: 51.507222, longitude: -0.1275).padding()
                    DriverView(name: "Dustin Ramseger", eta: 9, latitude: 49.4892913, longitude: 8.4673098).padding()
                    DriverView(name: "Luca Schimweg", eta: 4, latitude: 48.7784485, longitude: 9.1800132).padding()
                    Text("Searching for drivers...").font(.largeTitle).padding()
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
