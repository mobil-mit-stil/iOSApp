//
//  PassengerRequestView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI

struct PassengerRequestView: View {
    
    var controller: DriverController
    var passenger: DriverInformation
    
    init(controller: DriverController, passenger: DriverInformation) {
        self.controller = controller
        self.passenger = passenger
    }
    
    var body: some View {
        VStack {
            Text("A passenger on your route wants to be picked up!").font(.title).padding(15)
            Button(action: {
                controller.accept(passenger: passenger)
            }) {
                HStack {
                    Image(systemName: "figure.wave")
                        .font(.title)
                    Text("Accept!")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("AccentColor"))
                .cornerRadius(20)
                .padding(10)
            }
        }
        .background(Color("BackgroundTop"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding()
        
    }
}
