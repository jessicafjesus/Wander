//
//  PlaceDetailViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 31/03/2026.
//

import SwiftUI
import Combine
import CoreLocation

@MainActor
final class PlaceDetailViewModel: ObservableObject {
    @Published var note: String
    @Published var showingRemoveAlert = false
    @Published var isEditingNote = false
    
    private let item: WishlistItem
    private let wishlistStore: WishlistStore
    
    init(item: WishlistItem, wishlistStore: WishlistStore) {
        self.item = item
        self.wishlistStore = wishlistStore
        self.note = item.note ?? ""
    }
    
    var name: String { item.name }
    var city: String { item.city }
    var country: String { item.country }
    var description: String? { item.itemDescription }
    var coordinate: CLLocationCoordinate2D { item.coordinate }
    var addedAt: Date { item.addedAt }
    
    func saveNote() {
        wishlistStore.updateNote(for: item, note: note)
        isEditingNote = false
    }
    
    func cancelEdit() {
        note = item.note ?? ""
        isEditingNote = false
    }
    
    func remove() {
        wishlistStore.remove(item)
    }
}
