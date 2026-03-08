//
//  SearchViewModel.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import SwiftUI

@MainActor
@Observable
final class SearchViewModel {
    private let client: APIClient
    private var searchTask: Task<Void, Never>?
    private let wishlistStore: WishlistStore
    
    var state: ViewState = .empty
    var query: String = ""
        
    init(client: APIClient = .shared, wishlistStore: WishlistStore) {
        self.client = client
        self.wishlistStore = wishlistStore
    }
    
    func isInWishlist(_ place: Place) -> Bool {
        wishlistStore.isInWishlist(place)
    }
    
    func addToWishlist(_ place: Place) {
        wishlistStore.add(place)
    }
    
    func onQueryChanged() {
        searchTask?.cancel()
        
        guard query.count >= 2 else {
            state = .empty
            return
        }
        
        searchTask = Task {
            await search()
        }
    }
    
    private func search() async {
        state = .loading
        
        do {
            let places: [Place] = try await client.fetch(
                .searchPlaces(query: query)
            )
            state = places.isEmpty ? .empty : .loaded(places)
        } catch {
            if !Task.isCancelled {
                state = .error(error.localizedDescription)
            }
        }
    }
}

extension SearchViewModel {
    enum ViewState {
        case loading
        case loaded([Place])
        case empty
        case error(String)
    }
}
