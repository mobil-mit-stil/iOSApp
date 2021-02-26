//
//  ContentView.swift
//  Shared
//
//  Created by Michael Spilger on 26.02.21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack(alignment: .trailing) {
                WhereToGo().padding()
                DriverView(name: "Dumme Sau", eta: 4, latitude: 51.507222, longitude: -0.1275).padding()
            }
            
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
