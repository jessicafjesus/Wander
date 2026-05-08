//
//  SearchViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import SwiftUI
import MapboxSearch
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var state: ViewState = .idle
    @Published var query: String = ""
    
    private let placeAutocomplete: PlaceAutocomplete
    private(set) var wishlistStore: WishlistStore
    private var searchTask: Task<Void, Never>?
    
    init(wishlistStore: WishlistStore) {
        self.wishlistStore = wishlistStore
        self.placeAutocomplete = PlaceAutocomplete()
        // Mapbox reads the token from Info.plist automatically
    }
    
    func onQueryChanged() {
        searchTask?.cancel()
        
        guard query.count >= 2 else {
            state = .idle
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(400))
            guard !Task.isCancelled else { return }
            await search()
        }
    }
    
    func isInWishlist(_ suggestion: PlaceAutocomplete.Suggestion) -> Bool {
        wishlistStore.isInWishlist(id: suggestion.mapboxId)
    }
    
    // Two step process — first select the suggestion to get full result
    // then add to wishlist. This is required by Mapbox for billing.
    func addToWishlist(_ suggestion: PlaceAutocomplete.Suggestion) {
        Task {
            placeAutocomplete.select(suggestion: suggestion) { [weak self] result in
                switch result {
                case .success(let placeResult):
                    Task { @MainActor in
                        self?.wishlistStore.add(placeResult)
                    }
                case .failure(let error):
                    print("Selection error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func search() async {
        state = .loading
        
        placeAutocomplete.suggestions(for: query) { [weak self] result in
            Task { @MainActor in
                switch result {
                case .success(let suggestions):
                    self?.state = suggestions.isEmpty ? .empty : .loaded(suggestions)
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
