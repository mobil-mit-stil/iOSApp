//
//  WhereToGo.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 26.02.21.
//

import SwiftUI
import MapKit

struct WhereToGo: View {
    let defaults = UserDefaults.standard
    init() {
        self._freeSeats = State(initialValue: defaults.integer(forKey: "freeSeats"))
        self._passenger = State(initialValue: defaults.bool(forKey: "passenger"))
        self._destination = State(initialValue: defaults.string(forKey: "destination") ?? "")
    }
    
    @State var destination: String = "";
    @State private var passenger = true;
    @State private var freeSeats = 3
    var body: some View {
        VStack {
            Text("Tell me your destination!").bold().font(.largeTitle).padding()
            TextField("Example: Huawai Deutschland", text: $destination).font(.title2).padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            Picker(selection: $passenger, label: Text("What is your favorite color?")) {
                Text("Driver").tag(false)
                Text("Passenger").tag(true)
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
            if passenger {
                NavigationLink(destination: ChooseDriverView()) {
                    HStack {
                        Image(systemName: "figure.wave")
                            .font(.title)
                        Text("Lets Go!")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("AccentColor"))
                    .cornerRadius(20)
                    .padding(20)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    setTheValues()
                })
            } else {
                Stepper("Free seats:    \(freeSeats)", value: $freeSeats).padding()
                NavigationLink(destination: DriverNavigationView()) {
                    HStack {
                        Image(systemName: "car.fill")
                            .font(.title)
                        Text("Lets Go!")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("AccentColor"))
                    .cornerRadius(20)
                    .padding(20)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    setTheValues()
                })
            }
            
        }.background(Color("BackgroundTop"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        
    }
    func setTheValues() {
        defaults.setValue(freeSeats, forKey: "freeSeats")
        defaults.setValue(passenger, forKey: "passenger")
        defaults.setValue(destination, forKey: "destination")
    }
}

struct WhereToGo_Previews: PreviewProvider {
    static var previews: some View {
        WhereToGo()
    }
}
