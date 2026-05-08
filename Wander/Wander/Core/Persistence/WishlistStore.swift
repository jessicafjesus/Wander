//
//  WishlistStore.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import SwiftData
import Foundation
import MapboxSearch

@MainActor
@Observable
final class WishlistStore {
    private(set) var items: [WishlistItem] = []
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchItems()
    }
    
    func fetchItems() {
        let descriptor = FetchDescriptor<WishlistItem>(
            sortBy: [SortDescriptor(\.addedAt, order: .reverse)]
        )
        items = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func add(_ result: PlaceAutocomplete.Result, note: String? = nil) {
        guard !isInWishlist(id: result.mapboxId) else { return }
        let item = WishlistItem(from: result, note: note)
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
    
    func isInWishlist(id: String?) -> Bool {
        guard let id else { return false }
        return items.contains { $0.id == id }
    }
    
    private func save() {
        do {
            try modelContext.save()
            fetchItems()
        } catch {
            print("WishlistStore save error: \(error.localizedDescription)")
        }
    }
}
