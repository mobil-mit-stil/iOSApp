//
//  PassengerGetToDriverInfoView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI

struct PassengerGetToDriverInfoView: View {
    init(name: String, eta: Int) {
        self._name = State(initialValue: name)
        self._eta = State(initialValue: eta)
    }
    
    @State var name: String = ""
    @State var eta: Int = 0 // Estimated time of arrival
    var body: some View {
        VStack {
            if eta > 5 {
                Text("Your driver \(name) will be at your destination in ").foregroundColor(.black).padding()
                Text("\(eta)").bold().font(.largeTitle)
                Text("minutes.").padding()
            } else {
                Text("Your driver \(name) will be at your destination in ").foregroundColor(.black).padding()
                Text("less than 1 minute.").padding()
            }
           
        }.background(Color("BackgroundTop"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .font(.title)
        .padding()
    }
}

struct PassengerGetToDriverInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerGetToDriverInfoView(name: "Luca", eta: 3)
    }
}
