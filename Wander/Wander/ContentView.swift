//
//  ContentView.swift
//  Wander
//
//  Created by Jessica Jesus on 05/03/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    private var wishlistStore: WishlistStore
    
    init(wishlistStore: WishlistStore) {
        self.wishlistStore = wishlistStore
    }
    
    var body: some View {
        TabView {
            WanderMapView(
                viewModel: WanderMapViewModel(wishlistStore: wishlistStore)
            )
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            
//            WishlistView(
//                viewModel: WishlistViewModel(wishlistStore: wishlistStore)
//            )
//            .tabItem {
//                Label("Wishlist", systemImage: "heart.fill")
//            }
//            
//            SearchView(
//                viewModel: SearchViewModel(
//                    wishlistStore: wishlistStore
//                )
//            )
//            .tabItem {
//                Label("Search", systemImage: "magnifyingglass")
//            }
        }
//        .tint(.wanderAccent)
    }
}
