//
//  Location.swift
//  MobilMitStil (iOS)
//
//  Created by Michael Spilger on 27.02.21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func toModel() -> Location {
        return Location(latitude: self.latitude, longitude: self.longitude)
    }
}
