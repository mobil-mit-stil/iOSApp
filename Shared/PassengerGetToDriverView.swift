//
//  PassengerGetToDriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct PassengerGetToDriverView: View {
    init() {
        destinationPl = MapData()
        destinationPl.loadPlaceMark()
    }
    @ObservedObject var destinationPl:MapData
    @State private var directions: [MKRoute.Step] = []
    @State private var showDirections = false

  var body: some View {
    ZStack {
        MapView(directions: $directions, destination: $destinationPl.placeMark).ignoresSafeArea()
        VStack {

                ScrollView() {
                    ForEach(directions, id: \.self) { direction in
                        NavigationDirectionsView(direction: direction.instructions)
                    }
                }.frame(height: 200, alignment: .top)
                
            Spacer()
            PassengerGetToDriverInfoView(name: "Luca", eta: 4)
        }
    }.navigationBarHidden(true)
  }
}



struct PassengerGetToDriverView_Previews: PreviewProvider {
  static var previews: some View {
    PassengerGetToDriverView()
  }
}
