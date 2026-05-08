//
//  WanderMapViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import SwiftUI
import MapboxMaps
import Combine

@MainActor
final class WanderMapViewModel: ObservableObject {
    @Published var selectedItem: WishlistItem?
    @Published var viewport: Viewport = .camera(
        center: CLLocationCoordinate2D(
            latitude: 52.3676,
            longitude: 4.9041
        ),
        zoom: 3.5,
        bearing: 0,
        pitch: 0
    )
    
    private(set) var wishlistStore: WishlistStore
    
    init(wishlistStore: WishlistStore) {
        self.wishlistStore = wishlistStore
    }
    
    var items: [WishlistItem] { wishlistStore.items }
    var isEmpty: Bool { wishlistStore.items.isEmpty }
    
    func selectItem(_ item: WishlistItem) {
        withAnimation(.spring()) {
            selectedItem = item
        }
    }
    
    func flyTo(_ item: WishlistItem) {
        withAnimation {
            viewport = .camera(
                center: item.coordinate,
                zoom: 12,
                bearing: 0,
                pitch: 0
            )
        }
    }
    
    func resetCamera() {
        withAnimation {
            viewport = .camera(
                center: CLLocationCoordinate2D(
                    latitude: 52.3676,
                    longitude: 4.9041
                ),
                zoom: 3.5,
                bearing: 0,
                pitch: 0
            )
        }
    }
}
