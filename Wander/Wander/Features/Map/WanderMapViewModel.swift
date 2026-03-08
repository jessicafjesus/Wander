//
//  WanderMapViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Combine
import SwiftUI
import MapKit

@MainActor
@Observable
final class WanderMapViewModel {
    private let wishlistStore: WishlistStore
    private var cancellables = Set<AnyCancellable>()
    
    var selectedItem: WishlistItem?
    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 52.3676,
                longitude: 4.9041
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 20,
                longitudeDelta: 20
            )
        )
    )
    
    var items: [WishlistItem] { wishlistStore.items }
    
    init(wishlistStore: WishlistStore) {
        self.wishlistStore = wishlistStore
    }
    
    func selectItem(_ item: WishlistItem) {
        withAnimation(.spring()) {
            selectedItem = item
        }
    }
    
    func clearSelection() {
        selectedItem = nil
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
}
