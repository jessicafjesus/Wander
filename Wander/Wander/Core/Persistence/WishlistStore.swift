//
//  WishlistStore.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import SwiftData
import Foundation
import Combine

@MainActor
@Observable
final class WishlistStore {
    private(set) var items: [WishlistItem] = []
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchItems()
    }
    
    private func fetchItems() {
        let descriptor = FetchDescriptor<WishlistItem>(
            sortBy: [SortDescriptor(\.addedAt, order: .reverse)]
        )
        items = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func add(_ place: Place, note: String? = nil) {
        guard !isInWishlist(place) else { return }
        let item = WishlistItem(from: place, note: note)
        modelContext.insert(item)
        save()
    }
    
    func remove(_ item: WishlistItem) {
        modelContext.delete(item)
        save()
    }
    
    func updateNote(for item: WishlistItem, note: String) {
        item.note = note
        save()
    }
    
    func isInWishlist(_ place: Place) -> Bool {
        items.contains { $0.id == place.id }
    }
    
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("WishlistStore save error: \(error.localizedDescription)")
        }
    }
}
