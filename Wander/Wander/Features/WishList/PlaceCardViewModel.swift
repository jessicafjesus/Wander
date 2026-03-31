//
//  PlaceCardViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 31/03/2026.
//

import SwiftUI
import Combine

@MainActor
final class PlaceCardViewModel: ObservableObject {
    private let item: WishlistItem
    private let wishlistStore: WishlistStore
    
    init(item: WishlistItem, wishlistStore: WishlistStore) {
        self.item = item
        self.wishlistStore = wishlistStore
    }
    
    var name: String { item.name }
    var city: String { item.city }
    var country: String { item.country }
    var note: String? { item.note }
    var addedAt: Date { item.addedAt }
    
    func remove() {
        wishlistStore.remove(item)
    }
}
