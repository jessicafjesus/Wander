//
//  WishlistItem.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation
import SwiftData
import CoreLocation
import MapboxSearch

@Model
final class WishlistItem {
    var id: String
    var name: String
    var city: String
    var country: String
    var itemDescription: String?
//    var itemImage: Image?
    var latitude: Double
    var longitude: Double
    var note: String?
    var addedAt: Date
    
    init(from result: PlaceAutocomplete.Result, note: String? = nil) {
        self.id = result.mapboxId ?? result.name
        self.name = result.name
        self.city = result.address?.place ?? ""
        self.country = result.address?.country ?? ""
        self.itemDescription = result.description
//        self.itemImage = result.primaryImage
        self.latitude = result.coordinate?.latitude ?? 0
        self.longitude = result.coordinate?.longitude ?? 0
        self.note = note
        self.addedAt = Date()
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
