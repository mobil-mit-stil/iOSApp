//
//  NavigationDirectionsView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI

struct NavigationDirectionsView: View {
    
    init(direction: String) {
        self._direction = State(initialValue: direction)
    }
    @State var direction: String = ""
    
    var body: some View {
        VStack {
            Text(direction).font(.largeTitle).padding(15)
        }.frame(width: UIScreen.screenWidth * 0.9, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color("BackgroundTop"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding()
    }
}

struct NavigationDirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDirectionsView(direction: "Go to the left")
    }
}
