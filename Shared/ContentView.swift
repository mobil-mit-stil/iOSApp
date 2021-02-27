//
//  ContentView.swift
//  Shared
//
//  Created by Michael Spilger on 26.02.21.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
            /*
            NavigationLink(destination: HomeView()) {
                Text("Press on me")
            }.buttonStyle(PlainButtonStyle())
            */
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
