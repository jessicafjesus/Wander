//
//  Place.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation
import CoreLocation

struct Place: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let city: String
    let country: String
    let description: String?
    let imageURL: URL?
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
