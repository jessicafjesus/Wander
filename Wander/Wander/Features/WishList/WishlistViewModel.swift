//
//  WishlistViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 30/03/2026.
//

import Combine
import SwiftUI

@MainActor
final class WishlistViewModel: ObservableObject {
    private(set) var wishlistStore: WishlistStore
    
    init(wishlistStore: WishlistStore) {
        self.wishlistStore = wishlistStore
    }
    
    var items: [WishlistItem] { wishlistStore.items }
    var isEmpty: Bool { wishlistStore.items.isEmpty }
    
    func remove(_ item: WishlistItem) {
        wishlistStore.remove(item)
    }
}
