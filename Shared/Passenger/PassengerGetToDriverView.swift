//
//  PassengerGetToDriverView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit
import Lottie

struct PassengerGetToDriverView: View {
    var controller: PassengerController
    @ObservedObject var data: PassengerData
    
    init(controller: PassengerController) {
        self.controller = controller
        self.data = controller.data
    }
    
    var body: some View {
        if controller.data.driverAcceptanceStatus != .accepted {
            VStack {
                LottieView(name: "lottie").frame(width:UIScreen.screenWidth, height:300)
                Text("Waiting for the driver's approval").font(.title2).bold()
            }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).background(Color("Background"))
        } else {
            ZStack {
                MapView(data: data.mapDisplayData).ignoresSafeArea()
                VStack {
                    if self.data.mapDisplayData.directions != nil {
                        ScrollView() {
                            ForEach(self.data.mapDisplayData.directions!, id: \.self) { direction in
                                NavigationDirectionsView(direction: direction.instructions)
                            }
                        }.frame(height: 200, alignment: .top)
                        
                        Spacer()
                       
                    }
                    PassengerGetToDriverInfoView(name: names.name, eta: 4).offset(y: 200)

                    
                }
            }.navigationBarHidden(true)
        }
    }
}


struct LottieView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var name: String!
    
    var animationView = AnimationView()
    
    class Coordinator: NSObject {
        var parent: LottieView
        
        init(_ animationView: LottieView) {
            self.parent = animationView
            super.init()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}

