//
//  MapView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @ObservedObject var data: MapDisplayData;
    
    //@Binding var directions: [MKRoute.Step]
    //@Binding var destination: MKPlacemark
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(
            center: data.currentLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        mapView.setRegion(region, animated: true)
        
        mapView.addAnnotations([MKPlacemark(coordinate: data.currentLocation), MKPlacemark(coordinate: data.destination)])
        mapView.addAnnotations(data.stops)  // TODO: - Error Handeling for polyline if data.stops = 0 or if data.route = nil
        if data.route != nil { // Nil when you are at the same position - notify your driver is here
            mapView.addOverlay(data.route!.polyline)
            mapView.setVisibleMapRect(
                data.route!.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
            data.directions = data.route!.steps.map { $0 }.filter { !$0.instructions.isEmpty }
        }
        
        
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        
        let region = MKCoordinateRegion(
            center: data.currentLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        view.setRegion(region, animated: true)
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}
