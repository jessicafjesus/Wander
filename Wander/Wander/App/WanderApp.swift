//
//  WanderApp.swift
//  Wander
//
//  Created by Jessica Jesus on 05/03/2026.
//

import SwiftUI
import SwiftData

@main
struct WanderApp: App {
    var body: some Scene {
        WindowGroup {
            AppEntryView()
        }
        .modelContainer(for: WishlistItem.self)
    }
}

struct AppEntryView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ContentView(
            wishlistStore: WishlistStore(modelContext: modelContext)
        )
    }
}
