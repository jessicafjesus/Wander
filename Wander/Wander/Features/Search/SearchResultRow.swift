//
//  SearchResultRow.swift
//  Wander
//
//  Created by Jessica Jesus on 30/03/2026.
//

import SwiftUI
import MapboxSearch

struct SearchResultRow: View {
    let suggestion: PlaceAutocomplete.Suggestion
    let isInWishlist: Bool
    let onAdd: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.wanderAccent.opacity(0.15))
                    .frame(width: 60, height: 60)
                Image(systemName: iconForCategory(suggestion.categories.first))
                    .font(.title2)
                    .foregroundStyle(Color.wanderAccent)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(suggestion.name)
                    .font(.headline)
                    .lineLimit(1)
                if let subtitle = suggestion.description {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            Button {
                onAdd()
            } label: {
                Image(systemName: isInWishlist ? "heart.fill" : "heart")
                    .font(.title3)
                    .foregroundStyle(isInWishlist ? .red : .wanderAccent)
                    .animation(.spring(), value: isInWishlist)
            }
            .disabled(isInWishlist)
        }
        .padding(12)
        .background(Color.wanderCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // Map Mapbox categories to SF Symbols
    private func iconForCategory(_ category: String?) -> String {
        switch category {
        case "restaurant", "food": return "fork.knife"
        case "hotel", "lodging": return "bed.double.fill"
        case "museum": return "building.columns.fill"
        case "airport": return "airplane"
        case "park": return "leaf.fill"
        case "shopping": return "bag.fill"
        case "cafe": return "cup.and.saucer.fill"
        default: return "mappin.circle.fill"
        }
    }
}
