//
//  SearchView.swift
//  Wander
//
//  Created by Jessica Jesus on 30/03/2026.
//

import SwiftUI
import MapboxSearch

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .idle:
                    idleState
                    
                case .loading:
                    ProgressView("Exploring the world...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .loaded(let suggestions):
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(suggestions, id: \.mapboxId) { suggestion in
                                SearchResultRow(
                                    suggestion: suggestion,
                                    isInWishlist: viewModel.isInWishlist(suggestion),
                                    onAdd: { viewModel.addToWishlist(suggestion) }
                                )
                            }
                        }
                        .padding()
                    }
                    
                case .empty:
                    ContentUnavailableView.search(text: viewModel.query)
                    
                case .error(let message):
                    ContentUnavailableView(
                        "Couldn't Search",
                        systemImage: "wifi.exclamationmark",
                        description: Text(message)
                    )
                }
            }
            .navigationTitle("Explore 🌍")
            .searchable(
                text: $viewModel.query,
                prompt: "Search cities, landmarks..."
            )
            .onChange(of: viewModel.query) {
                viewModel.onQueryChanged()
            }
        }
    }
    
    private var idleState: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe.europe.africa.fill")
                .font(.system(size: 60))
                .foregroundStyle(Color.wanderAccent.opacity(0.6))
            Text("Where do you want to go?")
                .font(.title3.weight(.medium))
            Text("Search for any city or place\nand add it to your wishlist")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

