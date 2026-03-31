//
//  WishlistView.swift
//  Wander
//
//  Created by Jessica Jesus on 31/03/2026.
//

import SwiftUI

struct WishlistView: View {
    @StateObject var viewModel: WishlistViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isEmpty {
                    ContentUnavailableView(
                        "Your Wishlist is Empty",
                        systemImage: "airplane.departure",
                        description: Text("Search for places and start building your dream trip.")
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.items) { item in
                                NavigationLink(value: item) {
                                    PlaceCardView(
                                        viewModel: PlaceCardViewModel(
                                            item: item,
                                            wishlistStore: viewModel.wishlistStore  
                                        )
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Wander ✈️")
            .navigationDestination(for: WishlistItem.self) { item in
                PlaceDetailView(
                    viewModel: PlaceDetailViewModel(
                        item: item,
                        wishlistStore: viewModel.wishlistStore
                    )
                )
            }
        }
    }
}
