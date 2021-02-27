//
//  MapView.swift
//  MobilMitStil
//
//  Created by Michael Spilger on 27.02.21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let locationManager = CLLocationManager()
    
  typealias UIViewType = MKMapView
  
    @Binding var directions: [MKRoute.Step]
    @Binding var destination: MKPlacemark
  
  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    
    let location: CLLocationCoordinate2D = locationManager.location!.coordinate
    
    let region = MKCoordinateRegion(
      center: location,
      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    mapView.setRegion(region, animated: true)
    
    // NYC
    let p1 = MKPlacemark(coordinate: location)
    
    // Boston
    
    
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: p1)
    request.destination = MKMapItem(placemark: destination)
    request.transportType = .automobile
    
    let directions = MKDirections(request: request)
    directions.calculate { response, error in
      guard let route = response?.routes.first else { return }
      mapView.addAnnotations([p1, destination])
      mapView.addOverlay(route.polyline)
      mapView.setVisibleMapRect(
        route.polyline.boundingMapRect,
        edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
        animated: true)
        self.directions = route.steps.map { $0 }.filter { !$0.instructions.isEmpty }
    }
    return mapView
  }
  
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
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
