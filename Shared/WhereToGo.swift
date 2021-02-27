//
//  WhereToGo.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 26.02.21.
//

import SwiftUI

struct WhereToGo: View {
    @State var destination: String = "";
    var body: some View {
        VStack {
            Text("Tell me your destination!").bold().font(.largeTitle).padding()
            TextField("Example: Huawai Deutschland", text: $destination).font(.title2).padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding()
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
        }.background(Color("BackgroundTop"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        
    }
}

struct WhereToGo_Previews: PreviewProvider {
    static var previews: some View {
        WhereToGo()
    }
}
