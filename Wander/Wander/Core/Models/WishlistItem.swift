//
//  WishlistItem.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class WishlistItem {
    var id: String
    var name: String
    var city: String
    var country: String
    var itemDescription: String?
    var imageURLString: String?
    var latitude: Double
    var longitude: Double
    var note: String?
    var addedAt: Date
    
    init(from place: Place, note: String? = nil) {
        self.id = place.id
        self.name = place.name
        self.city = place.city
        self.country = place.country
        self.itemDescription = place.description
        self.imageURLString = place.imageURL?.absoluteString
        self.latitude = place.latitude
        self.longitude = place.longitude
        self.note = note
        self.addedAt = Date()
    }
    
    var imageURL: URL? {
        guard let string = imageURLString else { return nil }
        return URL(string: string)
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
